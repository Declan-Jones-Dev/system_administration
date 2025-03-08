#Below are scripts for troubleshooting an EC2 instance issue

# 1. Instance Launch Failures

#Check Resource Limits - verify that the account has not exceeded the resource limits in the specified region
aws ec2 describe-account-attributes --attribute-names max-instances

#Check AMI configuration to ensure it is correct and not corrupted
