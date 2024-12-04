#!/bin/bash

# Advanced File and Directory Operations Script

echo "=== Advanced File and Directory Operations Overview ==="

# 1. Create a directory with a timestamp
echo "=== Create a Directory with Timestamp ==="
timestamp_dir="$(date +%Y%m%d_%H%M%S)_backup"
mkdir "$timestamp_dir"
echo "Directory '$timestamp_dir' created."
echo ""

# 2. Create a nested directory structure
echo "=== Create a Nested Directory Structure ==="
read -p "Enter the parent directory path: " parent_dir
mkdir -p "$parent_dir"/{child1,child2,child3/{subchild1,subchild2}}
echo "Nested directory structure created under '$parent_dir'."
echo ""

# 3. Remove a non-empty directory with confirmation
echo "=== Remove a Non-Empty Directory with Confirmation ==="
read -p "Enter the directory to remove: " remove_dir
rm -ri "$remove_dir"
echo "Directory '$remove_dir' removed."
echo ""

# 4. Copy files with a progress indicator
echo "=== Copy Files with Progress Indicator ==="
read -p "Enter the source directory to copy: " source_dir
read -p "Enter the destination directory: " destination_dir
rsync -ah --progress "$source_dir/" "$destination_dir/"
echo "Files copied from '$source_dir' to '$destination_dir'."
echo ""

# 5. Move files based on pattern
echo "=== Move Files Based on Pattern ==="
read -p "Enter the source directory to move files from: " move_source
read -p "Enter the destination directory: " move_destination
read -p "Enter the file pattern (e.g., *.txt): " file_pattern
mv "$move_source"/"$file_pattern" "$move_destination/"
echo "Files matching pattern '$file_pattern' moved from '$move_source' to '$move_destination'."
echo ""

# 6. Rename files in bulk
echo "=== Rename Files in Bulk ==="
read -p "Enter the directory containing files to rename: " rename_dir
for file in "$rename_dir"/*.jpg; do
    mv "$file" "${file%.jpg}_backup.jpg"
done
echo "Files in '$rename_dir' renamed with '_backup' suffix."
echo ""

# 7. List files with human-readable sizes
echo "=== List Files with Human-Readable Sizes ==="
read -p "Enter the directory to list files: " list_dir
du -h "$list_dir"/*
echo ""

# 8. Find and delete empty directories
echo "=== Find and Delete Empty Directories ==="
read -p "Enter the directory to search for empty directories: " search_dir
find "$search_dir" -type d -empty -delete
echo "Empty directories in '$search_dir' have been deleted."
echo ""

# 9. Create a symbolic link
echo "=== Create a Symbolic Link ==="
read -p "Enter the path to the original file or directory: " original_path
read -p "Enter the path for the symbolic link: " symlink_path
ln -s "$original_path" "$symlink_path"
echo "Symbolic link created from '$original_path' to '$symlink_path'."
echo ""