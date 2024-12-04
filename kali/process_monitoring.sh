#!/bin/bash

# Process Monitoring Script

echo "=== Process Monitoring Overview ==="

# 1. Display currently running processes
echo "=== Currently Running Processes ==="
ps aux | less
echo ""

# 2. Interactive process viewer
echo "=== Interactive Process Viewer (top) ==="
echo "Press 'q' to exit."
top
echo ""

# 3. Enhanced process viewer (htop)
if command -v htop &> /dev/null; then
    echo "=== Enhanced Process Viewer (htop) ==="
    echo "Press 'q' to exit."
    htop
else
    echo "htop is not installed. You can install it using: sudo apt install htop"
fi
echo ""

# 4. Search for a specific process
echo "=== Search for a Specific Process ==="
read -p "Enter the process name to search: " process_name
pgrep "$process_name"
echo ""

# 5. Kill a specific process
echo "=== Kill a Specific Process ==="
read -p "Enter the process name to kill: " kill_process
pkill "$kill_process"
echo "Process '$kill_process' killed."
echo ""

# 6. Display processes in a tree format
echo "=== Process Tree ==="
pstree
echo ""

# 7. Report system performance
echo "=== System Performance Report (vmstat) ==="
vmstat 1 5
echo ""

# 8. List open files
echo "=== List of Open Files ==="
lsof | less
echo ""

# 9. Display network connections
echo "=== Network Connections ==="
netstat -tuln
echo ""

# 10. Report statistics by process ID
echo "=== Process Statistics ==="
pidstat 1 5
echo ""

echo "=== Process Monitoring Complete ==="