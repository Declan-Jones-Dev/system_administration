#!/bin/bash

# Software Management Script

echo "=== Software Management ==="

while true; do
    echo "1. Update Package List"
    echo "2. Upgrade Installed Packages"
    echo "3. Install a Package"
    echo "4. Remove a Package"
    echo "5. Purge a Package"
    echo "6. Search for a Package"
    echo "7. Show Package Information"
    echo "8. Clean Up Unused Packages"
    echo "9. View Installed Packages"
    echo "10. Exit"
    read -p "Select an option [1-10]: " option

    case $option in
        1)
            echo "=== Updating Package List ==="
            sudo apt update
            echo ""
            ;;
        2)
            echo "=== Upgrading Installed Packages ==="
            sudo apt upgrade -y
            echo ""
            ;;
        3)
            read -p "Enter the package name to install: " pkg_name
            echo "=== Installing $pkg_name ==="
            sudo apt install "$pkg_name" -y
            echo ""
            ;;
        4)
            read -p "Enter the package name to remove: " pkg_name
            echo "=== Removing $pkg_name ==="
            sudo apt remove "$pkg_name" -y
            echo ""
            ;;
        5)
            read -p "Enter the package name to purge: " pkg_name
            echo "=== Purging $pkg_name ==="
            sudo apt purge "$pkg_name" -y
            echo ""
            ;;
        6)
            read -p "Enter the package name to search: " pkg_name
            echo "=== Searching for $pkg_name ==="
            apt search "$pkg_name"
            echo ""
            ;;
        7)
            read -p "Enter the package name to show information: " pkg_name
            echo "=== Package Information for $pkg_name ==="
            apt show "$pkg_name"
            echo ""
            ;;
        8)
            echo "=== Cleaning Up Unused Packages === Cleaning Up Unused Packages ==="
            sudo apt autoremove -y
            echo ""
            ;;
        9)
            echo "=== Viewing Installed Packages ==="
            dpkg --get-selections | grep -v deinstall
            echo ""
            ;;
        10)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done

echo "=== Software Management Completed ===" 

### Additional Software Management Tips

1. **Check for Held Packages**
   - Identify packages that are on hold and not upgraded.
   ```bash
   dpkg --get-selections | grep hold