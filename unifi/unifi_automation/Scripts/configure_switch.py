## This script uses SSH to configure a Unifi switch

import paramiko


# Switch details
HOSTNAME = "192.168.1.10" # Replace with your actual switch's IP
USERNAME = "admin" # Replace with your actual switch's username
PASSWORD = "password" # Replace with your actual switch's password
PORT = 22 # SSH port number

def configure_switch():
    """Configure a unifi switch via SSH"""
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(HOSTNAME, PORT, USERNAME, PASSWORD)

    commands = [
        "configure",
        "set vlan 10 name IoT_Network",
        "set interface 0.10 vlan 10",
        "commit",
        "save",
        "exit"
    ]

    for command in commands:
        stdin, stdout, stderr = client.exec_command(command)
        print(stdout.read().decode())

    client.close()
    print("Switch configuration completed")

if __name__ == "__main__":
    configure_switch()