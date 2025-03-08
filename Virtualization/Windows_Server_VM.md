<h3> Below are instructions for downloading windows server vm ISO image and initializing a windows server hypervisor using VMBox in numerous operating systems</h3>

#
Please note: using windows server requires that you sign up. You're better to use an older version, (2019 or older), as an evaluation iso to virtualize the machine image.
#

<h4> Using Powershell, (ps1) </h4>

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/p/?linkid=2195686&clcid=0x409&culture=en-us&country=us" -OutFile "C:\path\to\file.iso" -Method Get -UseBasicParsing

<h4> For Ubuntu/Linux/Red Hat/CentOS </h4>

1) wget "https://go.microsoft.com/fwlink/p/?linkid=2195686&clcid=0x409&culture=en-us&country=us" -O ~/Downloads/WindowsServer.iso

2) curl -L "https://go.microsoft.com/fwlink/p/?linkid=2195686&clcid=0x409&culture=en-us&country=us" -o ~/Downloads/WindowsServer.iso

<h4> Initialize VM using Oracle VMBox </h4>

#
Create a New VM
#

VBox createvm --name "WindowsServer" --ostype "Windows2019_64" --register

#
Set VM Memory and CPU
#

VBoxManage modifyvm "WindowsServer" --memory 4096 --vcpus 2

#
Create a virtual hard disk
#

VBoxManage createhd --filename "C:\path\to\yourVMname.vdi" --size 20480 --format VDI

#
Attach the virtual hard disk to the VM
#

VBoxManage storagectl "WindowsServer" --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage storagectl "WindowsServer" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\path\to\youVMname.vdi"

#
Attach the Windows Server ISO
#

VBoxManage stroagectl "WindowsServer" --name "IDE Controller" --add ide

VBoxManage storageattach "WindowsServer" --storagectl "IDE Controller" --port 0 --device 0 --type devddrive --medium "C:\path\to\WindowsServer.iso"

#
Configure Network Settings, (optional)
#

VBoxManage modifyvm "YourVMName" --nic1 nat

#
Start the VM
#

VBoxManage startvm "WindowsServer" --type headless

