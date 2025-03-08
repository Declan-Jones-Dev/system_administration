For all of the listed scripts, ensure to do this first:

1) Open powershell as an administrator.

2) Run this command: Set-ExecutionPolicy RemoteSigned - This allows you to change the user preference script execution polichy to RemoteSigned - allowing you to execute and locally created or remote downloaded powershell script.

3) cd "~/path/to/your/script/"

4) Run the script with "./name_of_your_script.ps1"