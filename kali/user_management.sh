#!/bin/bash

# User Management Script

echo "=== User Management Overview ==="

# 1. List all users
echo "=== List of Users ==="
cat /etc/passwd | cut -d: -f1
echo ""

# 2. Add a new user
echo "=== Add a New User ==="
read -p "Enter the username to add: " new_user
sudo adduser "$new_user"
echo "User  '$new_user' added."
echo ""

# 3. Delete a user
echo "=== Delete a User ==="
read -p "Enter the username to delete: " del_user
sudo deluser "$del_user"
echo "User  '$del_user' deleted."
echo ""

# 4. Change a user's password
echo "=== Change User Password ==="
read -p "Enter the username to change password: " passwd_user
sudo passwd "$passwd_user"
echo "Password for user '$passwd_user' changed."
echo ""

# 5. Modify a user
echo "=== Modify a User ==="
read -p "Enter the username to modify: " mod_user
read -p "Enter the new home directory (leave blank to skip): " new_home
if [ -n "$new_home" ]; then
    sudo usermod -d "$new_home" "$mod_user"
    echo "Home directory for user '$mod_user' changed to '$new_home'."
fi
echo ""

# 6. Add a user to a group
echo "=== Add User to Group ==="
read -p "Enter the username to add to a group: " group_user
read -p "Enter the group name: " group_name
sudo usermod -aG "$group_name" "$group_user"
echo "User  '$group_user' added to group '$group_name'."
echo ""

# 7. Remove a user from a group
echo "=== Remove User from Group ==="
read -p "Enter the username to remove from a group: " rm_user
read -p "Enter the group name: " rm_group
sudo gpasswd -d "$rm_user" "$rm_group"
echo "User  '$rm_user' removed from group '$rm_group'."
echo ""

# 8. Show user groups
echo "=== Show User Groups ==="
read -p "Enter the username to show groups: " show_user
groups "$show_user"
echo ""

# 9. Lock a user account
echo "=== Lock a User Account ==="
read -p "Enter the username to lock: " lock_user
sudo usermod -L "$lock_user"
echo "User  account '$lock_user' locked."
echo ""

# 10. Unlock a user account
echo "=== Unlock a User Account ==="
read -p "Enter the username to unlock: " unlock_user
sudo usermod -U "$unlock_user"
echo "User  account '$unlock_user' unlocked."

echo "=== User Management Complete ==="