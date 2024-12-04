#!/bin/bash

# Performance Monitoring Script

echo "=== Performance Monitoring Overview ==="

# 1. View System Resource Usage
echo "=== System Resource Usage (top) ==="
echo "Press 'q' to exit."
top -b -n 1 | head -n 20
echo ""

# 2. Monitor CPU Usage (htop)
echo "=== CPU Usage (htop) ==="
echo "Press 'q' to exit."
htop
echo ""

# 3. Check Memory Usage
echo "=== Memory Usage ==="
free -h
echo ""

# 4. Disk Usage
echo "=== Disk Usage ==="
df -h
echo ""

# 5. Monitor Disk I/O
echo "=== Disk I/O Statistics (iostat) ==="
iostat -xz 1 3
echo ""

# 6. Check Network Usage
echo "=== Network Usage (iftop) ==="
read -p "Enter the network interface to monitor (e.g., eth0): " network_interface
echo "Press 'q' to exit."
sudo iftop -i "$network_interface"
echo ""

# 7. System Load
echo "=== System Load ==="
uptime
echo ""

# 8. Check Running Processes
echo "=== Running Processes ==="
ps aux --sort=-%mem | head -n 10
echo ""

# 9. View System Logs
echo "=== System Logs ==="
echo "Displaying the last 20 lines of system logs."
journalctl -xe | tail -n 20
echo ""

# 10. Monitor System Performance Over Time
echo "=== System Performance Over Time (sar) ==="
sar -u 1 3
echo ""

echo "=== Performance Monitoring Completed ==="