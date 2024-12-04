#!/bin/bash

# Network Configuration Management Script

echo "=== Network Configuration Management ==="

while true; do
    echo "1. View Network Interfaces"
    echo "2. Bring Up an Interface"
    echo "3. Bring Down an Interface"
    echo "4. Assign IP Address to an Interface"
    echo "5. Remove IP Address from an Interface"
    echo "6. Check Routing Table"
    echo "7. Add a Route"
    echo "8. Delete a Route"
    echo "9. Check DNS Configuration"
    echo "10. Test Connectivity"
    echo "11. Exit"
    read -p "Select an option [1-11]: " option

    case $option in
        1)
            echo "=== Network Interfaces ==="
            ip addr show
            echo ""
            ;;
        2)
            read -p "Enter the interface name to bring up: " iface
            sudo ip link set "$iface" up
            echo "Interface $iface brought up."
            echo ""
            ;;
        3)
            read -p "Enter the interface name to bring down: " iface
            sudo ip link set "$iface" down
            echo "Interface $iface brought down."
            echo ""
            ;;
        4)
            read -p "Enter the interface name: " iface
            read -p "Enter the IP address (e.g., 192.168.1.100): " ip_addr
            read -p "Enter the subnet mask (e.g., 24 for 255.255.255.0): " subnet_mask
            sudo ip addr add "$ip_addr/$subnet_mask" dev "$iface"
            echo "IP address $ip_addr/$subnet_mask assigned to $iface."
            echo ""
            ;;
        5)
            read -p "Enter the interface name: " iface
            read -p "Enter the IP address to remove: " ip_addr
            read -p "Enter the subnet mask (e.g., 24 for 255.255.255.0): " subnet_mask
            sudo ip addr del "$ip_addr/$subnet_mask" dev "$iface"
            echo "IP address $ip_addr/$subnet_mask removed from $iface."
            echo ""
            ;;
        6)
            echo "=== Routing Table ==="
            ip route show
            echo ""
            ;;
        7)
            read -p "Enter the destination (e.g., 192.168.1.0/24): " dest
            read -p "Enter the gateway: " gateway
            read -p "Enter the interface name: " iface
            sudo ip route add "$dest " via "$gateway" dev "$iface"
            echo "Route to $dest via $gateway added."
            echo ""
            ;;
        8)
            read -p "Enter the destination to delete: " dest
            sudo ip route del "$dest"
            echo "Route to $dest deleted."
            echo ""
            ;;
        9)
            echo "=== DNS Configuration ==="
            cat /etc/resolv.conf
            echo ""
            ;;
        10)
            read -p "Enter the hostname or IP to ping: " host
            ping -c 4 "$host"
            echo ""
            ;;
        11)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done

echo "=== Network Configuration Management Completed ===" ### Additional Network Configuration Tips

1. **Check Network Status**
   - Use `nmcli` to check the status of network connections.
   ```bash
   nmcli device status