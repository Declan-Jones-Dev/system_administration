#!/bin/bash

# CPU Analysis Script

echo "=== CPU Usage Overview ==="

# 1. Real-time system processes and CPU usage
echo "=== Top Processes ==="
top -b -n 1 | head -n 20
echo ""

# 2. Enhanced version of top (if installed)
if command -v htop &> /dev/null; then
    echo "=== Htop (if installed) ==="
    htop -b -n 1 | head -n 20
else
    echo "htop is not installed."
fi
echo ""

# 3. Reports CPU usage for all processors
echo "=== MPStat ==="
mpstat -P ALL 1 3
echo ""

# 4. Reports information about processes, memory, paging, block I/O, traps, and CPU activity
echo "=== VMStat ==="
vmstat 1 3
echo ""

# 5. Reports CPU and input/output statistics for devices
echo "=== IOSTAT ==="
iostat -c 1 3
echo ""

# 6. Collects and reports system activity information, including CPU usage
echo "=== SAR ==="
sar -u 1 3
echo ""

# 7. Reports statistics by process or by thread, including CPU usage
echo "=== PIDSTAT ==="
pidstat 1 3
echo ""

echo "=== CPU Analysis Complete ==="