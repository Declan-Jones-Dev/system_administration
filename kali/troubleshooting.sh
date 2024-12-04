#!/bin/bash

# Troubleshooting Script

echo "=== Troubleshooting Overview ==="

while true; do
    echo "1. Check System Logs"
    echo "2. Check Disk Space"
    echo "3. Check Memory Usage"
    echo "4. Check CPU Usage"
    echo "5. Check Running Processes"
    echo "6. Check Network Configuration"
    echo "7. Ping a Host"
    echo "8. Check Services Status"
    echo "9. Restart a Service"
    echo "10. Check Firewall Status"
    echo "11. Exit"
    read -p "Select an option [1-11]: " option

    case $option in
        1)
            echo "=== System Logs ==="
            journalctl -xe
            echo ""
            ;;
        2)
            echo "=== Disk Space ==="
            df -h
            echo ""
            ;;
        3)
            echo "=== Memory Usage ==="
            free -h
            echo ""
            ;;
        4)
            echo "=== CPU Usage ==="
            top -b -n 1 | head -n 20
            echo ""
            ;;
        5)
            echo "=== Running Processes ==="
            ps aux --sort=-%mem | head -n 10
            echo ""
            ;;
        6)
            echo "=== Network Configuration ==="
            ip addr show
            echo ""
            ;;
        7)
            echo "=== Ping a Host ==="
            read -p "Enter the hostname or IP address: " host
            ping -c 4 "$host"
            echo ""
            ;;
        8)
            echo "=== Check Services Status ==="
            read -p "Enter the service name: " service_name
            systemctl status "$service_name"
            echo ""
            ;;
        9)
            echo "=== Restart a Service ==="
            read -p "Enter the service name to restart: " service_name
            sudo systemctl restart "$service_name"
            echo "Service $service_name restarted."
            echo ""
            ;;
        10)
            echo "=== Firewall Status ==="
            sudo ufw status
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

echo "=== Troubleshooting Completed ==="