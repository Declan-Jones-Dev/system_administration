## Installing and Configuring Veeam Endpoint Backup

# Step 1: Download Veeam Agent for Microsoft Windows
1) Open your web browser, (google, chrome, firefox, etc.) and search up the Veeam official website in the search bar using this URL:

https://www.veeam.com/endpoint-backup-free.html

2) Scroll down to the section labeled "Free Veeam Agent for Microsoft Windows"

3) Click the "Download Free" button to download the installer file

4) Save the installer file (e.g. VeeamAgentWindows_<version>.exe) to a known location on your computer, such as the "Downloads" or "Desktop" folder, (downloaded to "Downloads" folder by default).

# Step 2: Install Veeam Agent

1) Locate the downloaded installer file in the Downloads folder

2) Double-click the installer file to run it and start the installation

3) Follow the on-screen instructions to complete the installation:

-Click "Next" to continue with the installation
-Select the language and click "Next"
-License Agreement: Accept the terms and click "Next"
-Installation Type: Select Typical Installation, (recommended for most users), then click install
-Wait for the installation to complete.

4) Once the installation is finished, check the box that says "Launch Veeam Agent for Microsoft Windows" and click Finish

Step 3: Configure Veeam Agent for Backup
After launching Veeam Agent, the Initial Configuration Wizard will appear. Click Next to proceed.
Select Backup Mode :
Choose Entire computer if you want to back up the entire system (recommended for full protection).
Alternatively, choose Volume level backup or File level backup if you only need to back up specific files or volumes.
Click Next .
Specify Backup Destination :
Choose where you want to store the backup:
Local storage (e.g., external hard drive or network share).
Cloud storage (if you have a Veeam Cloud Connect account).
For simplicity, select Local storage and specify the path to the backup location (e.g., D:\Backups).
Click Next .
Set Backup Schedule :
Choose how often you want the backup to run:
Daily : Backups occur once per day.
Weekly : Backups occur on specific days of the week.
Set the time for the backup to start (e.g., 2:00 AM).
Click Next .
Retention Policy :
Specify how many restore points to keep (e.g., 7 restore points).
Older backups will be automatically deleted when the retention limit is reached.
Click Next .
Summary :
Review the configuration settings.
If everything looks correct, click Finish to save the backup job.
Step 4: Run the First Backup
After completing the configuration, Veeam Agent will display the main dashboard.
To manually start the first backup:
Click the Backup Now button.
Monitor the progress in the dashboard.
Once the backup is complete, verify that the backup files are stored in the specified location.

# Step 5: Test the Restore Process

1) To ensure the backup works correctly, test restoring a file or folder:

-Open Veeam Agent
-Go to the Restore tab 
-Select the backup job and browse the restore points
-Choose a file or folder to restore and specify the desitnation

2) Verify that the restored data matches the original.