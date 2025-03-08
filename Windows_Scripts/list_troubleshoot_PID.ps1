# Get list of processes in descending order of cpu usage
$processes = Get-Process | Sort-Object CPU -Descending

# Display the header 
Write-Host "Procss Name `nCPU Usage (%) `nMemory Usage (MB) `n"

# Loop through each process and display relevant information
foreach ($process in $processes) {
    $cpuUsage = "{0:N2}" -f ($process.CPU)
    $memoryUsage = "{0:N2}" -f ($process.WorkingSet / 1MB) # Convert bytes to MB
    Write-Host "$($process.ProcessName)`n$($process.Id) `n$cpuUsage`n$memoryUsage`n"
}
# Prompt user for further action
Write-Host "If you suspect a process is causing issues, you can investigate further."
Write-Host "To get more details about a specific process, enter its Process ID (PID):"
$pid = Read-Host

# Check if the entered PID is valid
if ($processes.Id -contains $pid) {
    $selectedProcess = Get-Process -Id $pid
    Write-Host "Details for process ID: $pid:"
    Write-Host "Process Name: $($selectedProcess.ProcessName)"
    Write_Host "CPU Usage: $($selectedProcess.CPU)"
    Write_Host "Memory Usage: $($selectedProcess.WorkingSet / 1MB) MB"
}