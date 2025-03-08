# Configuring a Windows VM with Hypervisor

## **Objective**
To create and configure a Windows virtual machine (VM) using a hypervisor, ensuring it is ready for use. This guide will walk you through the process step-by-step, making it easy for anyone to follow.

---

## **Prerequisites**
Before starting, ensure the following:
1. **Hypervisor Installed**: Install a hypervisor such as:
   - [Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/) (Windows Pro/Enterprise/Education)
   - [VMware Workstation Player](https://www.vmware.com/products/workstation-player.html) (Free for personal use)
   - [Oracle VirtualBox](https://www.virtualbox.org/) (Free and open-source)
2. **Windows ISO File**: Download the Windows ISO file from the official Microsoft website:
   - URL: [https://www.microsoft.com/software-download/windows10](https://www.microsoft.com/software-download/windows10)
3. **System Requirements**:
   - Sufficient RAM (at least 4 GB recommended for the VM).
   - Free disk space (at least 20 GB for the VM).
   - A processor that supports virtualization (Intel VT-x or AMD-V).

---

## **Step 1: Enable Virtualization in BIOS/UEFI**
1. Restart your computer and enter the BIOS/UEFI settings:
   - Press the appropriate key during boot (common keys: `F2`, `F10`, `DEL`, or `ESC`).
2. Locate the **Virtualization Technology** setting:
   - It may be labeled as **Intel VT-x**, **AMD-V**, or **SVM Mode**.
3. Enable the setting and save changes before exiting.

---

## **Step 2: Install and Set Up the Hypervisor**
### **For Hyper-V (Windows Built-In)**
1. Open **Control Panel** > **Programs** > **Turn Windows features on or off**.
2. Check the box for **Hyper-V** and click **OK**.
3. Restart your computer to complete the installation.

### **For VMware Workstation Player or VirtualBox**
1. Download and install the hypervisor from its official website.
2. Launch the application after installation.

---

## **Step 3: Create a New Virtual Machine**
### **For Hyper-V**
1. Open **Hyper-V Manager** (`Windows + S`, search for "Hyper-V Manager").
2. In the right-hand pane, click **New > Virtual Machine**.
3. Follow the wizard:
   - **Name**: Provide a name for the VM (e.g., "Windows10-VM").
   - **Generation**: Select **Generation 2** (recommended for modern systems).
   - **Memory**: Allocate at least 4 GB of RAM.
   - **Network**: Connect to a virtual switch (create one if necessary).
   - **Hard Disk**: Create a new virtual hard disk (default size: 20 GB).
   - **Installation Media**: Browse to the Windows ISO file you downloaded.
4. Complete the wizard and start the VM.

### **For VMware Workstation Player**
1. Open VMware Workstation Player.
2. Click **Create a New Virtual Machine**.
3. Follow the wizard:
   - Select the Windows ISO file as the installation media.
   - Choose the version of Windows (e.g., Windows 10).
   - Allocate resources:
     - **Memory**: At least 4 GB.
     - **Disk Space**: At least 20 GB.
4. Finish the setup and power on the VM.

### **For VirtualBox**
1. Open VirtualBox.
2. Click **New** to create a new VM.
3. Follow the wizard:
   - **Name**: Provide a name (e.g., "Windows10-VM").
   - **Type**: Select **Microsoft Windows**.
   - **Version**: Choose the appropriate version (e.g., Windows 10 (64-bit)).
   - **Memory**: Allocate at least 4 GB.
   - **Hard Disk**: Create a new virtual hard disk (default size: 20 GB).
4. After creation, select the VM and click **Settings**:
   - Go to **Storage** > **Controller: IDE** > **Empty**.
   - Click the disc icon and choose the Windows ISO file.
5. Start the VM.

---

## **Step 4: Install Windows on the VM**
1. Start the VM and boot from the ISO file.
2. Follow the Windows installation wizard:
   - Select language, time, and keyboard preferences.
   - Enter the product key (if required).
   - Choose **Custom Installation** and select the virtual hard disk.
3. Wait for the installation to complete. The VM will restart several times during this process.

---

## **Step 5: Configure the Windows VM**
1. **Install VMware Tools, VirtualBox Guest Additions, or Hyper-V Integration Services**:
   - These tools improve performance and enable features like shared clipboard and better display resolution.
   - For VMware: Go to **Player > Manage > Install VMware Tools**.
   - For VirtualBox: Go to **Devices > Insert Guest Additions CD Image**.
   - For Hyper-V: Integration Services are installed automatically.
2. **Update Windows**:
   - Open **Settings > Update & Security > Windows Update** and install all available updates.
3. **Install Necessary Drivers**:
   - Ensure all hardware components (e.g., network adapter, sound card) are functioning properly.
4. **Set Up Networking**:
   - Verify the VM has internet access.
   - For bridged networking, the VM will have its own IP address on the local network.

---

## **Step 6: Test the VM**
1. Restart the VM to ensure it boots correctly.
2. Test functionality:
   - Internet connectivity.
   - Display resolution and performance.
   - Shared folders or clipboard (if configured).
3. Confirm the VM is ready for use.
