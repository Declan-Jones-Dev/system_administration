#!/bin/bash

# Network Analysis Script

echo "=== Network Analysis Overview ==="

# 1. Display network interface configuration
echo "=== Ifconfig ==="
ifconfig
echo ""

# 2. Show IP addresses assigned to interfaces
echo "=== IP Addresses ==="
ip addr show
echo ""

# 3. Check connectivity to a remote host
echo "=== Ping Example.com ==="
ping -c 4 example.com
echo ""

# 4. Display active connections and listening ports
echo "=== Netstat ==="
netstat -an
echo ""

# 5. Perform a network scan on a target IP
echo "=== Nmap Scan ==="
nmap -sV target_ip
echo ""

# 6. Trace the route to a remote host
echo "=== Traceroute to Example.com ==="
traceroute example.com
echo ""

# 7. Display ARP table
echo "=== ARP Table ==="
arp -a
echo ""

# 8. Capture packets on a specific interface
echo "=== TCPDump on eth0 ==="
tcpdump -i eth0 -c 10
echo ""

# 9. Perform a DNS lookup
echo "=== DNS Lookup for Example.com ==="
dig example.com
echo ""

# 10. Download a file from the web
echo "=== Downloading File ==="
wget http://example.com/file.zip
echo ""

echo "=== Network Analysis Complete ==="