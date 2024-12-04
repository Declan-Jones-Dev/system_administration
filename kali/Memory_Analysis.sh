#!/bin/bash

# Memory Analysis Script

echo "=== Memory Usage Overview ==="

# 1. Display total free and used memory
echo "=== Free Memory ==="
free -h
echo ""

# 2. Reports information about processes, memory, paging, block I/O, traps, and CPU activity
echo "=== VMStat ==="
vmstat 1 3
echo ""

# 3. Display real-time processes and memory usage
echo "=== Top Processes ==="
top -b -n 1 | head -n 20
echo ""

# 4. Enhanced version of top (if installed)
if command -v htop &> /dev/null; then
    echo "=== Htop (if installed) ==="
    htop -b -n 1 | head -n 20
else
    echo "htop is not installed."
fi
echo ""

# 5. Reports memory usage with a detailed view
echo "=== Smem ==="
smem -r -k
echo ""

# 6. Display memory map of a specific process (replace <pid> with actual PID)
echo "=== Pmap (replace <pid> with actual PID) ==="
echo "For example, for PID 1:"
pmap -x 1
echo ""

# 7. Detailed information about memory usage
echo "=== /proc/meminfo ==="
cat /proc/meminfo
echo ""

# 8. Collects and reports memory usage information
echo "=== SAR ==="
sar -r 1 3
echo ""

echo "=== Memory Analysis Complete ==="