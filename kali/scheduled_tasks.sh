#!/bin/bash

# System Information Script

echo "=== System Information Overview ==="

# 1. General System Information
echo "=== General System Information (uname) ==="
uname -a
echo ""

# 2. OS Version
echo "=== OS Version (lsb_release) ==="
lsb_release -a
echo ""

# 3. Hardware Information
echo "=== Hardware Information (lshw) ==="
sudo lshw -short
echo ""

# 4. CPU Information
echo "=== CPU Information (lscpu) ==="
lscpu
echo ""

# 5. Memory Information
echo "=== Memory Information (free) ==="
free -h
echo ""

# 6. Disk Information
echo "=== Disk Information (lsblk) ==="
lsblk
echo ""

# 7. PCI Devices
echo "=== PCI Devices (lspci) ==="
lspci
echo ""

# 8. USB Devices
echo "=== USB Devices (lsusb) ==="
lsusb
echo ""

# 9. Network Interfaces
echo "=== Network Interfaces (ip) ==="
ip addr show
echo ""

# 10. System Uptime and Load
echo "=== System Uptime and Load (uptime) ==="
uptime
echo ""

echo "=== System Information Gathering Completed ==="