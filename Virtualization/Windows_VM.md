<h2>*Below are instructions and scripts for downloading oracle VMBox to virtualize operating systems as hypervisor machine instances*</h2>

<h3>For Windows, (using Powershell)</h3>

<h4>1. Download VirtualBox</h4>

Invoke-WebRequest -Uri "https://download.virtualbox.org/virtualbox/6.1.4/VirtualBox-6.1.40-150911-Win.exe" -OutFile "C:\Users\$env:USERNAME\Downloads\VirtualBox.exe"

<h4> 2. Install VirtualBox</h4>

Start-Process -FilePath "C:\Users\$env:USERNAME\Downloads\VirtualBox.exe" -ArgumenyList "/S" -Wait

<h4>3. Download Windows 11 ISO</h4>

Invoke-WebRequest -Uri "https://software-download.microsoft.com/xxxxx/Win11_English_x64.iso" -OutFile "C:\Users\$env:USERNAME\Downloads\Windows11.iso"

<h4> 4. Create a new Virtual Machine</h4>

cd "C:\Program Files\Oracle\VirtualBox"

.\VBoxManage.exe createvm --name "Windows11" --register

.\VBoxManage.exe modifyvm "Windows11" --memory 4096 --cpus 2 --ostype "Windows11_64"

.\VBoxManage.exe createhd --filename "C:\Users\$env:USERNAME\VirtualBox VMs\Windows11\Windows11.vdi" --size 65536

.\VBoxManage.exe storagectl "Windows11" --name "SATA Controller" --add sata --controller IntelAhci

.\VBoxManage.exe storageattach "Windows11" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\Users\$env:USERNAME\VirtualBox VMs\Windows11\Windows11.vdi"

.\VMBoxManage.exe storageattach "Windows11" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "C:\Users\$env:USERNAME\Downloads\Windows11.iso"

<h4> 5. Start the Virtual Machine</h4>

.\VBoxManage.exe startvm "Windows11" --type headless

<h3> For Ubuntu </h3>

<h4> 1. Update and Install Dependencies </h4>

sudo apt update
sudo apt install -y wget apt-transport-https

<h4> 2. Download VirtualBox </h4>

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -0- | sudo apt-key add -

echo "deb htttps://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

sudo apt update
sudo apt install -y virtualbox-6.1

<h4> 3. Download Windows 11 ISO </h4>

wget -O ~/Downloads/Windows11.iso "https://software-download.microsoft.com/xxxxx/Win11_English_x64.iso"

*For all of these windows iso's, to virtualize windows server instead of windows 11, you would need to change the iso url to the windows server iso url: https://software-download.microsoft.com/xxxxx/WinServer_English_x64.iso*