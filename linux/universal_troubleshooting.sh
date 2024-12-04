#!/bin/bash

# Function to check system information
check_system_info() {
    echo "=== System Information ==="
    uname -a
    echo "Kernel Version: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Disk Usage:"
    df -h
    echo "Memory Usage:"
    free -h
    echo "CPU Info:"
    lscpu | grep 'Model name'
    echo "=========================="
}

# Function to check for package manager
detect_package_manager() {
    if command -v apt > /dev/null; then
        echo "Package Manager: APT (Debian/Ubuntu)"
        PM="apt"
    elif command -v yum > /dev/null; then
        echo "Package Manager: YUM (Red Hat/CentOS)"
        PM="yum"
    elif command -v dnf > /dev/null; then
        echo "Package Manager: DNF (Fedora/RHEL 8+)"
        PM="dnf"
    elif command -v pacman > /dev/null; then
        echo "Package Manager: Pacman (Arch Linux)"
        PM="pacman"
    else
        echo "No recognized package manager found."
        PM=""
    fi
}

# Function to check for installed packages
check_installed_packages() {
    echo "=== Installed Packages ==="
    if [ "$PM" == "apt" ]; then
        dpkg --get-selections | grep -v deinstall
    elif [ "$PM" == "yum" ]; then
        yum list installed
    elif [ "$PM" == "dnf" ]; then
        dnf list installed
    elif [ "$PM" == "pacman" ]; then
        pacman -Q
    fi
    echo "=========================="
}

# Function to check network connectivity
check_network() {
    echo "=== Network Connectivity ==="
    echo "IP Address: $(hostname -I | awk '{print $1}')"
    echo "Ping Test to 8.8.8.8 (Google DNS):"
    ping -c 4 8.8.8.8
    echo "=========================="
}

# Function to check for device issues
check_devices() {
    echo "=== Device Status ==="
    lsblk
    echo "====================="
}

# Main script execution
echo "=== Starting System Troubleshooting Script ==="
check_system_info
detect_package_manager
check_installed_packages
check_network
check_devices
echo "=== Troubleshooting Complete ==="
