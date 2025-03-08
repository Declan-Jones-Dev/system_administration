#GENERAL COMMANDS

#Copy the output of a command to your clipboard
| clip

#Find a particular string or part of an output
| findstr <string>


# CPU INFO AND SYSADMIN COMMANDS

#Device IP address
ipconfig 

#Find all IP related information, (DNS and MAC address included)
ipconfig /all

#Create pipe to find a particular item/substring of results in command, (in this case find DNS in ipconfig /all)
ipconfig /all | findstr DNS

#Release and reallocate a device's IP address
ipconfig /release 
ipconfig /renew

#Display a list of website's known by local machine and their DNS's
ipconfig /displaydns

#Flush the DNS Resolver Cache on your local Machine
ipconfig /flushdns

#Lookup IP address(es) of a particular DNS
nslookup

# List all available application upgrades on current Windows OS machine
winget upgrade

# Complete all available upgrades on said Windows machine
winget upgrade --all

#ADMINISTRATIVE TROUBLESHOOTING

# Repair Windows OS machine image and applications using known good copies as reference point

# Repairs specific application on machine
winget repair <appname>
# Blackbox troubleshooting approach: isolate and test individual components
# Isolate and test individual application components
winget repair <appname> --verbose

# Isolate and test individual system components
sfc /scannow --verbose
DISM /Online /Cleanup-Image /CheckHealth --verbose
DISM /Online /Cleanup-Image /ScanHealth --verbose
DISM /Online /Cleanup-Image /RepairHealth --verbose

'' The verbose section indicates the machine to give you a detailed description of processes and results of the script ''