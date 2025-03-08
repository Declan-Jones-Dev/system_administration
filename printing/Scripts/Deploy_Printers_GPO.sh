# Define printer details
$printerName = "OfficePrinter"
$printerPort = "192.168.1.100"
$printerDriver = "HP Universal Printing PCL 6"

# Create a new printer port
Add-PrinterPort -Name $printerPort -PrinterHostAddress $printerPort
Write-Host

# Install the printer
Add-Printer -Name $printerName -DriverName $printerDriver -PortName $printerPort
Write-Host "Install printer: $printerName"

# Set printer as default
Set-Printer -Name $printerName -Default $true
Write-Host "Printer: $printerName set as default printer"

Write-Host "Printer deployment completed"