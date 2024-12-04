#!/bin/bash

# Cloud Management Script

echo "=== Cloud Management ==="

read -p "Enter the AMI ID: " ami_id
read -p "Enter the instance type (e.g., t2.micro): " instance_type
read -p "Enter the key pair name: " key_name

echo "Launching EC2 instance..."
aws ec2 run-instances --image-id "$ami_id" --count 1 --instance-type "$instance_type" --key-name "$key_name"

echo "EC2 instance launched successfully."