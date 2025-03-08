# Get the chrome process
$chromeProcess = Get-Process chrome | Where-Object { $_.MainWindowTitle -like "*Download*" }

# Check if the process is found, and if so reallocate resource priority
if($chromeProcess) {
    $chromeProcess.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
    Write-Host "Priority of Chrome download process set to High."

} else {
    Write-Host "No Chrome download process found."
}