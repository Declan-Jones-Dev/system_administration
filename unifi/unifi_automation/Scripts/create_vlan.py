##### **1. create_vlan.py**
## This script uses the UniFi REST API to create a VLAN.

import requests

# Unifi Controller details
BASE_URL = "https://localhot:8443" # Replace with your controller's IP/URL
USERNAME = "your_admin_username"
PASSWORD = "your_admin_password"

# Disable SSL warning (for self-signed certificates)
requests.packages.urllib3.disable_warnings()

def login():
    '''Authenticate with the Unifi Controller'''
    login_url = f"{BASE_URL}/api/auth/login"
    payload = {"username": USERNAME, "password": PASSWORD}
    session = requests.Session()
    response = session.post(login_url, json=payload, verify=False)
    if response.status_code == 200:
        print("Login successfull")
        return session
    else:
        print("Login failed", response.text)
        exit()

def create_vlan(session, vlan_id, name, subnet, gateway, dhcp_start, dhcp_stop):
    """Create a VLAN using unifi api"""
    vlan_data = {
        "name": name,
        "vlan_id": vlan_id,
        "subnet": subnet,
        "gateway": gateway,
        "dhcp_start": dhcp_start,
        "dhcp_stop": dhcp_stop,
        "purpose": "corporate"
    }
    create_vlan_url = f"{BASE_URL}/api/s/default/rest/networkconf"
    response = session.post(create_vlan_url, json=vlan_data, verify=False)
    if response.status_code == 200:
        print(f"VLAN {vlan_id} created successfully")
    else:
        print("failed to create VLAN", response.text)


if __name__ == "__main__":
    session = login()
    create_vlan(
        session,
        vlan_id=10,
        name="IoT-Network",
        subnet="192.168.10.0/24", # Subnet CIDR range
        gateway="192.168.10.1", # Gateway or host IP address
        dhcp_start="192.168.10.10", # DHCP start IP address
        dhcp_start="192.168.10.100" # DHCP end IP address, (last configurable IP)
    )