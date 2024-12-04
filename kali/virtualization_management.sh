#!/bin/bash

# Virtualization Management Script

echo "=== Virtualization Management ==="

while true; do
    echo "1. List Virtual Machines"
    echo "2. Create a Virtual Machine"
    echo "3. Start a Virtual Machine"
    echo "4. Shutdown a Virtual Machine"
    echo "5. Delete a Virtual Machine"
    echo "6. Exit"
    read -p "Select an option [1-6]: " option

    case $option in
        1)
            echo "=== Listing Virtual Machines ==="
            virsh list --all
            echo ""
            ;;
        2)
            read -p "Enter VM name: " vm_name
            read -p "Enter RAM (MB): " ram
            read -p "Enter disk size (GB): " disk_size
            sudo virt-install \
            --name "$vm_name" \
            --ram "$ram" \
            --disk path=/var/lib/libvirt/images/"$vm_name".img,size="$disk_size" \
            --vcpus 2 \
            --os-type linux \
            --os-variant ubuntu20.04 \
            --network network=default \
            --graphics none \
            --cdrom /path/to/ubuntu.iso
            echo "Virtual Machine '$vm_name' created."
            echo ""
            ;;
        3)
            read -p "Enter VM name to start: " vm_name
            virsh start "$vm_name"
            echo "Virtual Machine '$vm_name' started."
            echo ""
            ;;
        4)
            read -p "Enter VM name to shutdown: " vm_name
            virsh shutdown "$vm_name"
            echo "Virtual Machine '$vm_name' is shutting down."
            echo ""
            ;;
        5)
            read -p "Enter VM name to delete: " vm_name
            virsh undefine "$vm_name"
            echo "Virtual Machine '$vm_name' deleted."
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

echo "=== Virtualization Management Completed ==="