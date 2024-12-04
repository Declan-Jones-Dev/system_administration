#!/bin/bash

# Firewall Management Script

echo "=== Firewall Management Overview ==="

# 1. Show current iptables rules
echo "=== Current iptables Rules ==="
sudo iptables -L -v
echo ""

# 2. Allow a port
echo "=== Allow Incoming Traffic on a Port ==="
read -p "Enter the port number to allow: " allow_port
sudo iptables -A INPUT -p tcp --dport "$allow_port" -j ACCEPT
echo "Allowed incoming traffic on port $allow_port."
echo ""

# 3. Deny a port
echo "=== Deny Incoming Traffic on a Port ==="
read -p "Enter the port number to deny: " deny_port
sudo iptables -A INPUT -p tcp --dport "$deny_port" -j DROP
echo "Denied incoming traffic on port $deny_port."
echo ""

# 4. Save iptables rules
echo "=== Saving iptables Rules ==="
sudo iptables-save > /etc/iptables/rules.v4
echo "iptables rules saved."
echo ""

# 5. Flush all iptables rules
echo "=== Flush All iptables Rules ==="
sudo iptables -F
echo "All iptables rules flushed."
echo ""

# 6. UFW status
echo "=== UFW Status ==="
sudo ufw status verbose
echo ""

# 7. Enable UFW
echo "=== Enable UFW ==="
sudo ufw enable
echo "UFW enabled."
echo ""

# 8. Allow a UFW port
echo "=== Allow Incoming Traffic on a UFW Port ==="
read -p "Enter the port number to allow in UFW: " ufw_allow_port
sudo ufw allow "$ufw_allow_port"
echo "Allowed incoming traffic on UFW port $ufw_allow_port."
echo ""

# 9. Deny a UFW port
echo "=== Deny Incoming Traffic on a UFW Port ==="
read -p "Enter the port number to deny in UFW: " ufw_deny_port
sudo ufw deny "$ufw_deny_port"
echo "Denied incoming traffic on UFW port $ufw_deny_port."
echo ""

echo "=== Firewall Management Complete ==="