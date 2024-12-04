#!/bin/bash

# Backup and Recovery Script

echo "=== Backup and Recovery Overview ==="

# 1. Create a backup of a directory
echo "=== Create a Backup of a Directory ==="
read -p "Enter the directory to backup: " backup_dir
read -p "Enter the name of the backup file (without extension): " backup_name
tar -czvf "${backup_name}.tar.gz" "$backup_dir"
echo "Backup of '$backup_dir' created as '${backup_name}.tar.gz'."
echo ""

# 2. Restore a backup
echo "=== Restore a Backup ==="
read -p "Enter the backup file to restore (with extension): " restore_file
read -p "Enter the directory to extract to: " extract_dir
tar -xzvf "$restore_file" -C "$extract_dir"
echo "Backup '$restore_file' restored to '$extract_dir'."
echo ""

# 3. Backup using rsync
echo "=== Backup using rsync ==="
read -p "Enter the source directory to backup: " rsync_source
read -p "Enter the destination directory for backup: " rsync_dest
rsync -av --delete "$rsync_source/" "$rsync_dest/"
echo "Backup of '$rsync_source' completed to '$rsync_dest'."
echo ""

# 4. Create a disk image
echo "=== Create a Disk Image ==="
read -p "Enter the disk to backup (e.g., /dev/sdX): " disk_to_backup
read -p "Enter the path to save the disk image: " disk_image_path
sudo dd if="$disk_to_backup" of="$disk_image_path" bs=4M
echo "Disk image of '$disk_to_backup' created at '$disk_image_path'."
echo ""

# 5. Restore a disk image
echo "=== Restore a Disk Image ==="
read -p "Enter the path of the disk image to restore: " restore_image_path
read -p "Enter the disk to restore to (e.g., /dev/sdX): " restore_disk
sudo dd if="$restore_image_path" of="$restore_disk" bs=4M
echo "Disk image '$restore_image_path' restored to '$restore_disk'."
echo ""

# 6. Backup MySQL Database
echo "=== Backup MySQL Database ==="
read -p "Enter MySQL username: " mysql_user
read -p "Enter database name to backup: " mysql_db
mysqldump -u "$mysql_user" -p "$mysql_db" > "${mysql_db}_backup.sql"
echo "MySQL database '$mysql_db' backed up as '${mysql_db}_backup.sql'."
echo ""

# 7. Restore MySQL Database
echo "=== Restore MySQL Database ==="
read -p "Enter MySQL username: " mysql_user_restore
read