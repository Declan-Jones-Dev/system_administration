# Setting Up Windows Server with Active Directory for an Organization

## **Objective**
To set up and configure a **Windows Server** with **Active Directory (AD)** to serve as the backbone of an organization's IT infrastructure. This guide will walk you through installing Windows Server, promoting it to a Domain Controller (DC), and configuring Active Directory for user management, group policies, and organizational units.

---

## **Prerequisites**
Before starting, ensure the following:
1. **Hardware Requirements**:
   - A dedicated server or virtual machine (VM) with at least:
     - 2 GHz processor
     - 4 GB RAM (8 GB recommended)
     - 40 GB free disk space
   - Static IP address configured on the server.
2. **Software Requirements**:
   - Windows Server ISO file (e.g., Windows Server 2022 or 2019).
   - Administrative access to the server.
3. **Network Requirements**:
   - A reliable network connection.
   - DNS configured correctly (AD requires DNS).

---

## **Step 1: Install Windows Server**

1. **Boot from the Installation Media**:
   - Insert the Windows Server ISO file into the server or VM.
   - Boot the server from the installation media (adjust boot order in BIOS/UEFI if necessary).

2. **Install Windows Server**:
   - On the setup screen, select your language, time, and keyboard preferences, then click **Next**.
   - Click **Install Now**.
   - Choose the desired edition (e.g., **Windows Server Standard** or **Datacenter**).
   - Accept the license terms and proceed with the installation.

3. **Select Installation Type**:
   - Choose **Custom: Install Windows only (advanced)**.
   - Select the disk where you want to install Windows Server and click **Next**.

4. **Complete the Installation**:
   - Wait for the installation to complete. The server will restart automatically.
   - After rebooting, set a strong password for the local administrator account.

---

## **Step 2: Configure the Server**

1. **Set a Static IP Address**:
   - Open **Server Manager**.
   - Go to **Local Server** > **Ethernet** (or your network adapter).
   - Set a static IP address:
     - IP Address: e.g., `192.168.1.10`
     - Subnet Mask: e.g., `255.255.255.0`
     - Default Gateway: e.g., `192.168.1.1`
     - Preferred DNS: Use the server's own IP address (e.g., `192.168.1.10`).

2. **Rename the Server**:
   - In **Server Manager**, go to **Local Server** > **Computer Name**.
   - Click **Change** and assign a meaningful name (e.g., `AD-Server`).
   - Restart the server after renaming.

---

## **Step 3: Install Active Directory Domain Services (AD DS)**

1. **Open Server Manager**:
   - Launch **Server Manager** from the Start menu.

2. **Add Roles and Features**:
   - Click **Manage** > **Add Roles and Features**.
   - In the wizard, click **Next** until you reach the **Server Roles** page.
   - Check the box for **Active Directory Domain Services**.
   - Add any required features when prompted and click **Next**.
   - Review the selections and click **Install**.

3. **Promote the Server to a Domain Controller**:
   - After installation, a notification will appear in **Server Manager**.
   - Click **Promote this server to a domain controller**.
   - Choose **Add a new forest** and enter a root domain name (e.g., `company.local`).
   - Set the **Domain and Forest Functional Levels** (e.g., Windows Server 2016 or higher).
   - Specify a **Directory Services Restore Mode (DSRM)** password.
   - Verify the DNS delegation settings and click **Next**.
   - Review the paths for the AD database, log files, and SYSVOL folder (default locations are fine for most setups).
   - Click **Next** and then **Install**.
   - The server will restart automatically after promotion.

---

## **Step 4: Configure Active Directory**

1. **Create Organizational Units (OUs)**:
   - Open **Active Directory Users and Computers** (`dsa.msc`).
   - Right-click the domain (e.g., `company.local`) and select **New > Organizational Unit**.
   - Create OUs for different departments or groups (e.g., `IT`, `Finance`, `HR`).

2. **Add Users and Groups**:
   - Right-click an OU (e.g., `IT`) and select **New > User**.
   - Fill in the user details (e.g., First Name, Last Name, Username).
   - Set a strong password and configure password policies (e.g., require password change at next login).
   - Create security groups (e.g., `IT-Admins`, `Finance-Users`) and add users to them.

3. **Delegate Permissions**:
   - Right-click an OU and select **Delegate Control**.
   - Use the wizard to grant specific permissions to users or groups (e.g., allow IT staff to reset passwords).

---

## **Step 5: Configure Group Policy Objects (GPOs)**

1. **Open Group Policy Management**:
   - Launch **Group Policy Management Console** (`gpmc.msc`).

2. **Create a New GPO**:
   - Right-click the domain or an OU and select **Create a GPO in this domain, and Link it here**.
   - Name the GPO (e.g., `Default Security Settings`).

3. **Configure Policies**:
   - Edit the GPO to enforce security and operational policies:
     - **Password Policies**: Set minimum password length, complexity, and expiration.
     - **Account Lockout Policies**: Define lockout thresholds and durations.
     - **User Restrictions**: Restrict access to removable storage or specific applications.
   - Apply the GPO to the appropriate OU or domain.

---

## **Step 6: Test the Active Directory Setup**

1. **Join a Client Computer to the Domain**:
   - On a client computer, open **System Properties** (`sysdm.cpl`).
   - Go to the **Computer Name** tab and click **Change**.
   - Select **Domain** and enter the domain name (e.g., `company.local`).
   - Provide domain admin credentials when prompted.
   - Restart the client computer.

2. **Log in with a Domain Account**:
   - Log in using a domain user account (e.g., `company\username`).
   - Verify that the user has access to shared resources and group policies.

3. **Verify DNS Functionality**:
   - Ensure the client computer resolves the domain name correctly.
   - Run `nslookup company.local` from the client to confirm DNS is working.