#!/bin/bash

# Environment Variables Management Script

echo "=== Environment Variables Management ==="

while true; do
    echo "1. View All Environment Variables"
    echo "2. View a Specific Environment Variable"
    echo "3. Set a Temporary Environment Variable"
    echo "4. Set a Permanent Environment Variable"
    echo "5. Unset an Environment Variable"
    echo "6. Exit"
    read -p "Select an option [1-6]: " option

    case $option in
        1)
            echo "=== All Environment Variables ==="
            printenv
            echo ""
            ;;
        2)
            read -p "Enter the variable name: " var_name
            echo "=== Value of $var_name ==="
            echo "${!var_name}"
            echo ""
            ;;
        3)
            read -p "Enter the variable name: " var_name
            read -p "Enter the value: " var_value
            export "$var_name=$var_value"
            echo "Temporary variable $var_name set to $var_value."
            echo ""
            ;;
        4)
            read -p "Enter the variable name: " var_name
            read -p "Enter the value: " var_value
            echo "export $var_name=$var_value" >> ~/.bashrc
            echo "Permanent variable $var_name set to $var_value. Please run 'source ~/.bashrc' to apply changes."
            echo ""
            ;;
        5)
            read -p "Enter the variable name to unset: " var_name
            unset "$var_name"
            echo "Variable $var_name unset."
            echo ""
            ;;
        6)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done

echo "=== Environment Variables Management Completed ==="