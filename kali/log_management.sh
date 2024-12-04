#!/bin/bash

# Log Management Script

echo "=== Log Management ==="

while true; do
    echo "1. View Syslog"
    echo "2. View Auth Log"
    echo "3. Search in Syslog"
    echo "4. Search in Auth Log"
    echo "5. Count Failed Login Attempts"
    echo "6. Clear Syslog"
    echo "7. Exit"
    read -p "Select an option [1-7]: " option

    case $option in
        1)
            echo "=== Viewing Syslog ==="
            less /var/log/syslog
            echo ""
            ;;
        2)
            echo "=== Viewing Auth Log ==="
            less /var/log/auth.log
            echo ""
            ;;
        3)
            read -p "Enter the search term: " search_term
            echo "=== Searching in Syslog for '$search_term' ==="
            grep "$search_term" /var/log/syslog
            echo ""
            ;;
        4)
            read -p "Enter the search term: " search_term
            echo "=== Searching in Auth Log for '$search_term' ==="
            grep "$search_term" /var/log/auth.log
            echo ""
            ;;
        5)
            echo "=== Counting Failed Login Attempts ==="
            count=$(grep -c "failed" /var/log/auth.log)
            echo "Number of failed login attempts: $count"
            echo ""
            ;;
        6)
            echo "=== Clearing Syslog ==="
            sudo truncate -s 0 /var/log/syslog
            echo "Syslog cleared."
            echo ""
            ;;
        7)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done

echo "=== Log Management Completed ==="