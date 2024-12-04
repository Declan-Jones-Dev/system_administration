#!/bin/bash

# System Logs Analysis Script

echo "=== System Logs Analysis Overview ==="

# 1. Display the contents of the syslog
echo "=== Syslog Contents ==="
cat /var/log/syslog | head -n 20
echo ""

# 2. Monitor the authentication log
echo "=== Monitoring Authentication Log (tail) ==="
tail -f /var/log/auth.log &
TAIL_PID=$!
sleep 10
kill $TAIL_PID
echo ""

# 3. View kernel log
echo "=== Kernel Log ==="
less /var/log/kern.log
echo ""

# 4. Search for errors in syslog
echo "=== Searching for Errors in Syslog ==="
grep "error" /var/log/syslog
echo ""

# 5. Query the systemd journal logs
echo "=== Systemd Journal Logs ==="
journalctl -xe | head -n 20
echo ""

# 6. Generate log summary with logwatch
echo "=== Logwatch Summary ==="
logwatch --detail high --range today
echo ""

# 7. Display kernel-related messages
echo "=== Kernel Messages (dmesg) ==="
dmesg | less
echo ""

# 8. Find log files modified in the last 7 days
echo "=== Log Files Modified in the Last 7 Days ==="
find /var/log -type f -mtime -7
echo ""

# 9. Analyze logs with awk
echo "=== Analyzing Logs with awk ==="
awk '/error/ {print $0}' /var/log/syslog
echo ""

# 10. Filter logs with sed
echo "=== Filtering Logs with sed ==="
sed -n 's/.*error.*/&/p' /var/log/syslog
echo ""

echo "=== System Logs Analysis Complete ==="