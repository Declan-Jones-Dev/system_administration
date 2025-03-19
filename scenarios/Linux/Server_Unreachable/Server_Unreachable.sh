#!/bin/bash

# ========================================================================
# Linux Server Recovery Script after Power Outage
# ========================================================================
# Purpose: Systematically troubleshoot and recover a Linux server after a
#          power outage when it's unreachable over the network
# Usage: sudo ./linux_server_recovery.sh
# Author: Declan Jones - DataCenter Auckland.
# Version: 1.0
# Last Updated: 2025-03-09
# ========================================================================

# Check if the script is running as root
if [ "$EUID" -ne 0]; then
echo "Please run as root or with sudo/su."
exit 1
fi

# Color formatting for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print section headers
section() {
    echo -e "\n${GREEN}==== $1 ====${NC}"
}

# Function to print info messages
info() {
    echo -e "${YELLOW}INFO:${NC} $1"
}

# Function to print errors
error() {
    echo -e "${RED}ERROR:${NC} $1"
}

# Interactive IP configuration
get_server_ip() {
    # Get local Ips first to help user
    section "LOCAL NETWORK INTERFACES"
    ip -4 addr show | grep -v "127.0.0.1" | grep "inet" | awk '{print $2}' | cut -d/ -f1

    read -p "Enter the problematic server's IP address:" SERVER_IP
    echo $SERVER_IP 
}

# Main script starts here
clear
echo "==========================="
echo "LINUX SERVER RECOVERY AFTER POWER OUTAGE"
echo "========================================="
echo "This script will guide you through recovering a Linux server"
echo "that's unreachable after a power outage."
echo 


# Verify physical status
section "PHYSICAL VERIFICATION CHECKLIST"
echo "Before proceeding with network troubleshooting, confirm the following:"
echo "[ ] Server is powered on with normal indicator lights"
echo "[ ] Network cables are properly connected"
echo "[ ] Cooling systems are operational"
read -p "Have you verified these items? (y/n):" physical_check
if [[ $physical_check != "y"]]; then
info "Please complete physical checks before proceeding."
fi 

# Get server IP
SERVER_IP=$(get_server_ip)
GATEWAY=$(ip_route | grep default | awk '{print $3}')

# Network connectivity tests
section "NETWORK CONNECTIVITY TESTING"

info "Testing ping to server at $SERVER_IP..."
ping -c 4 $SERVER_IP
if [$? -ne 0]; then
    error "Cannot ping server. Testing gateway connectivity..."

    info "Testing pint to gateway at $GATEWAY..."
    ping -c 4 $GATEWAY
    if [ $? -ne 0]; then
        error "Cannot ping gateway. Local network issues detected."
    else
    info "Gateway is reachable. Issue might be with server or switch port. Proceeding with server recovery."
    fi

    info "Tracing packet route to server"
    traceroute -n $SERVER_IP 

    info "Checking for open ports on server with netcat..."
    for port in 22 80 442 3306 5432; do
    echo "Testing port $port..."
    nc -zv -w 2 $SERVER_IP $port 2>&1
    done

    info "Testing ARP resolution..."
    arping -c 4 -I $(ip route get $SERVER_IP | grep -oP "dev \K\S+") $SERVER_IP 

    read -p "Would you like to perform a more intensive network scan? (y/n):" scan_option
    if [[ $scan_option == "y"]]; then
        if command -v nmap &> /dev/null; then 
            nmap -sP $SERVER_IP/24 # ping scan of the entire subnet
        else
            error "nmap not installed. Install with 'apt install nmap' or 'yum install nmap'"
        fi 
    fi 
else
    info "Server is pingable! Checking for SSH accessibility..."
    ssh -o "StrictHostKeyChecking=no" $SERVER_IP "echo 'Hello World!'"
    nc -zw -2 2 $SERVER_IP 22 2>&1
fi

# Console access instructions
section "CONSOLE ACCESS"
echo "If network troubleshooting is unsuccessful, direct console access is needed."
echo "1. Connect monitor and keyboard or use KVM switch/IPMI/iDRAC"
echo "2. Login with your admin credentials?"
read -p "Do you have access now? (y/n):" console_access

if [[ $console_access == "y"]]; then 
    section "FILESYSTEM CHECK"
    echo "Available disks:"
    lsblk

    read -p "Enter the disk to check (e.g. sda, vda):" disk_name
    info "Running filesystem check on /dev/$disk_name partitions..."

    # List partitions first
    echo "Available partitions:"
    lsblk -l /dev/$disk_name | grep part | awk '{print $1}'

    read -p "Enter specific partition to check (leave empty to check all):" partition 

    if [ -z "$partition"]; then 
        # Check all partitions
        for part in $(lsblk -ln -o NAME /dev/$disk_name | grep -v $disk_name); do
            echo "Checking /dev/$part..."
            echo "# Run: fsck -f /dev/$part"
            fsck -f /dev/$part
        done
    else
        echo "Checking /dev/$partition..."
        echo "# Run: fsck -f /dev/$partition"
        fsck -f /dev/$partition
    fi 

    section "NETWORK SERVICE CHECK"
    info "Checking network service status..."
    systemctl status networking

    info "Network interfaces"
    ip addr show

    info "Routing table:"
    ip route

    read -p "Enter the database type (mysql/postgresql/other):" db_type
    if [[ $db_type == "mysql"]]; then
        section "DATABASE SERVICE CHECK - MySQL"
        systemctl status mysql
        if [$? -ne 0] then; 
        echo "mysql database status inactive. Attempting to start now..." && systemctl start mysql 
        if [$? -ne 0] then;
            echo "MySQL database failed to start. Database error, please investigate further..."
    elif [[ $db_type == "postgresql"]]; then
        section "DATABASE SERVICE CHECK - PostgreSQL"
        systemctl status postgresql
        if [$? -ne 0] then;
        echo "postgresql database status inactive. Attempting to start now..." && systemctl start postgresql
        if [$? -ne 0] then;
            echo "Issue with PostgreSQL database. Please investigate further..."
    else
        section "GENERAL SERVICE CHECK"
        read -p "Enter the service name to check:" service_name
        systemctl status $service_name
        if [ $? -ne 0]; then 
            echo "Service $service_name status inactive, attempting to start now..." && systemctl start $service_name
        if [$? -ne 0]; then
        echo "Issue with $service_name database service. Further investigation is required."
    fi 

    section "NETWORK CONFIGURATION CHECK"
    info "Current netplan configuration:"
    cat /etc/netplan/*.yaml

    read -p "Do you need to edit netplan configuration? (y/n):" edit_netplan
    if [[ $edit_netplan == "y"]]; then
        nano /etc/netplan/01-netcfg.yaml
        info "Applying netplan configuration..."
        netplan apply
    fi 

    section "SYSTEM LOGS CHECK"
    info "Checking boot logs..."
    journalctl -xb | grep -i -E 'error|fail|critical'

    info "Checking hardware errors..."
    dmesg | grep -i -E 'error|fail|critical'

    section "RECOVERY STEPS"
    echo "Based on troubleshooting, here are recommended recovery steps:"
    echo "1. Repair any filesystem errors identified"
    echo "2. Ensure network services are running: systemctl restart networking"
    echo "3. Ensure database services are running: systemctl restart mysql/postgresql"
    echo "4. Implement UPS system to prevent future power-related issues"
    echo "5. Configure automatic startup for critical services:"
    echo "   systemctl enable mysql postgresql nginx apache2 etc."
else
    info "You need console access to continue deeper troubleshooting."
    info "Please arrange for physical access or remote KVM/IPMI access."
fi

section "SCRIPT COMPLETE"
echo "Troubleshooting tasks completed. If issues persist, consider:"
echo "1. Hardware diagnostics"
echo "2. Data recovery procedures"
echo "3. Restoring from backup if filesystem is corrupted"
exit 0
