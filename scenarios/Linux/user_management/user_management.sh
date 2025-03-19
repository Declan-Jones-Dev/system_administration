# ========================================================================
# User Management and Permissions Script for Linux
# ========================================================================
# Purpose: Manage users, groups, and permissions, including auditing access
# Usage: sudo ./user_management_and_permissions.sh
# Author: Declan Jones || DataCenter Auckland
# Version: 1.0
# Last Updated: 2025-03-14
# ========================================================================

# Color formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="user_management_and_permissions_$(date +%Y%m%d_%H%M%S).log"

# Function to print section headers
section() {
    echo -e "\n${BLUE}===== $1 =====${NC}\n"
    echo -e "===== $1 =====" >> "$LOG_FILE"
}

# Function to log command output
log_cmd() {
        echo -e "${CYAN}Running: $1${NC}"
    echo "Command: $1" >> "$LOG_FILE"
    eval "$1" | tee -a "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

# Function to check if script is running as root
check_root() {
    if ["$EUID" -ne 0]; then
        echo -e "${RED}This script needs to be run with root privileges (sudo) for full functionality"
        echo -e "${RED}Please restart with: sudo $0${NC}"
        exit 1
    fi
}

# Add a new user
add_user() {
    section "ADDING A NEW USER"

    read -p "Enter the username to add: " USERNAME
    read -p "Enter the home directory for $USERNAME (default: /home/$USERNAME): " HOMEDIR
    HOMEDIR=${HOMEDIR:-/home/$USERNAME}
    read -p "Enter the shell for $USERNAME (default: /bin/bash): " USERSHELL
    USERSHELL=${USERSHELL:-/bin/bash}

    log_cmd "useradd -m -d $HOMEDIR -s $USERSHELL $USERNAME"
    echo -e "${GREEN}User $USERNAME added successfully.${NC}"
}

# Delete a user
delete_user() {
    section "DELETING A USER"

    read -p "Enter the username to delete: " USERNAME
    read -p "Do you want to remove the home directory for $USERNAME (y/n): " REMOVE_HOME

    if [ "$REMOVE_HOME" == "y"]; then 
        log_cmd "userdel -r $USERNAME"
    else
        log_cmd "userdel $USERNAME"
    fi
    echo -e "${GREEN}User $USERNAME deleted successfully.${NC}"
}

# Add a new group
add_group() {
    section "ADDING A NEW GROUP"

    read -p "Enter the group name to add: " GROUPNAME

    log_cmd "groupadd $GROUPNAME"
    echo -e "${GREEN}Group $GROUPNAME added successfully.${NC}"
}

# Delete a group
delete_group() {
    section "DELETING A GROUP"

    read -p "Enter the group name to delete: " GROUPNAME

    log_cmd "groupdel $GROUPNAME"
    echo -e "${GREEN}Group $GROUPNAME deleted successfully.${NC}"
}

# Add a user to a group
add_user_to_group() {
    section "ADDING A USER TO A GROUP"

    read -p "Enter the username to add to a group: " USERNAME
    read -p "Enter the group name to add $USERNAME to: " GROUPNAME

    log_cmd "usermod -aG $GROUPNAME $USERNAME"
    echo -e "${GREEN}User ${USERNAME} added to group ${GROUPNAME} successfully.${NC}"
}

# Audit user access
audit_user_access() {
    section "AUDITING USER ACCESS"

    echo -e "${YELLOW}Listing all users:${NC}"
    log_cmd "getent passwd" && log_cmd "cut -d: -f1 /etc/passwd"

    echo -e "\n${YELLOW}Listing all groups:${NC}"
    log_cmd "cut -d: -f1 /etc/group"

    echo -e "\n${YELLOW}Listing all users and their groups:${NC}"
    log_cmd "getent passwd | cut -d: -f1 | xargs -n1 id"
}

# Main function
main() {
    check_root

    PS3="Select an option (enter number): "
    options=("Add User" "Delete User" "Add Group" "Delete Group" "Add User to Group" "Audit User Access" "Exit")

    select opt_in "${options[@]}"
    do
        case $opt_in 
            "Add User")
            add_user
            ;;
            "Delete User")
            delete_user
            ;;
            "Add Group")
                add_group
                ;;
            "Delete Group")
                delete_group
                ;;
            "Add User to Group")
                add_user_to_group
                ;;
            "Audit User Access")
                audit_user_access
                ;;
                "Exit")
                echo "Exiting User Management and Permissions script."
                break
                ;;
        *)
            echo :Invalid option $REPLY"
            ;;
    esac
    done

    section "SCRIPT COMPLETED"
    echo -e "${GREEN}User Mangement and Permissions tasks completed. Please review the log file: $LOG_FILES${NC}"
    }

# Execute the main function
main