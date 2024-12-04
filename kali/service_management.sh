#!/bin/bash

# Service Management Script

echo "=== Service Management Overview ==="

# 1. List all active services
echo "=== Active Services ==="
systemctl list-units --type=service
echo ""

# 2. Check the status of a specific service (replace <service_name> with actual service)
echo "=== Checking Status of a Service ==="
read -p "Enter the service name to check status: " service_name
systemctl status "$service_name"
echo ""

# 3. Start a service
echo "=== Starting a Service ==="
read -p "Enter the service name to start: " service_name
sudo systemctl start "$service_name"
echo "Service '$service_name' started."
echo ""

# 4. Stop a service
echo "=== Stopping a Service ==="
read -p "Enter the service name to stop: " service_name
sudo systemctl stop "$service_name"
echo "Service '$service_name' stopped."
echo ""

# 5. Restart a service
echo "=== Restarting a Service ==="
read -p "Enter the service name to restart: " service_name
sudo systemctl restart "$service_name"
echo "Service '$service_name' restarted."
echo ""

# 6. Enable a service to start on boot
echo "=== Enabling a Service ==="
read -p "Enter the service name to enable: " service_name
sudo systemctl enable "$service_name"
echo "Service '$service_name' enabled to start on boot."
echo ""

# 7. Disable a service from starting on boot
echo "=== Disabling a Service ==="
read -p "Enter the service name to disable: " service_name
sudo systemctl disable "$service_name"
echo "Service '$service_name' disabled from starting on boot."
echo ""

# 8. View logs for a specific service
echo "=== Viewing Logs for a Service ==="
read -p "Enter the service name to view logs: " service_name
journalctl -u "$service_name" | less
echo ""

# 9. Mask a service
echo "=== Masking a Service ==="
read -p "Enter the service name to mask: " service_name
sudo systemctl mask "$service_name"
echo "Service '$service_name' masked."
echo ""

# 10. Unmask a service
echo "=== Unmasking a Service ==="
read -p "Enter the service name to unmask: " service_name
sudo systemctl unmask "$service_name"
echo "Service '$service_name' unmasked."

echo "=== Service Management Complete ==="