# Define the path for the health check log, (change this as necessary to fit your use case).
$logFilePath = "C:\SystemHealth\SystemHealthLog.json"

# Function to check system health
function Check-SystemHealth {
    $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object -First 1
    $memInfo = Get-CimInstance Win32_OperatingSystem
    $memUsage = [math]::round(($memInfo.TotalVisibleMemorySize - $memInfo.FreePhysicalMemory) / $memInfo.TotalVisibleMemorySize * 100, 2)
    $diskInfo = Get-CimInstance Win32_LogicalDisk | WhereObject { $_.DriveType -eq 3 }

    $diskUsage = @()
    foreach ($disk in $diskInfo) {
        $freeSpace = [math]::round(($disk.FreeSpace / $disk.Size) * 100, 2)
        $diskUsage += @{ Drive = $disk.DeviceID; FreeSpace = $freeSpace }
    }

    return @{
        CPUUsage = [math]::round($cpuUsage.CookedValue, 2)
        MemoryUsage = $memUsage
        DiskUsage = $diskUsage
    }
}

# Function to rate system health
function Rate-SystemHealth {
    param (
        [hashtable]$healthMetrics
        )

        $rating = 100

        if ($healthMetrics.CPUUsage -gt 80) { rating -= 20 }
        if ($healthMetrics.MemoryUsage -gt 80) { rating -= 20 }
        foreach ($disk in $healthMetrics.DiskUsage) {
            if ($disk.FreeSpace -lt 20) {$rating -=20}
        }

        return $rating
        }

#Function to compare with last health check 
function Compare-Health {
    param (
        [hashtable]$currentMetrics,
        [hashtable]$lastMetrics
    )

    $degradation = @{}

    if ($lastMetrics) {
        $degradation.CPU = $currentMetrics.CPUUsage - $lastMetrics.CPUUsage
        $degradation.Memory = $currentMetrics.MemoryUsage - $lastMetrics.MemoryUsage
        $degradation.Disk = @()

        foreach($currentDisk in $currentMetrics.DiskUsage) {
            $lastDisk = $lastMetrics.DiskUsage | Where-Object { $_.Drive -eq $currentDisk.Drive }
            if ($lastDisk) {
                $degradation.Disk += @{ Drive = $currentDisk.Drive; Change = $currentDisk.FreeSpace - $lastDisk.FreeSpace }
            }
        }
    }
    
    return $degradation
}

# Functions to provide suggestions for improvement
function Suggest-Improvements {
    param (
        [hashtable]$healthMetrics
    )

    $suggestions = @()

    if($healthMetrics.CPUUsage -gt 80) { $suggestions += "Consider optimizing running applications or adding more CPU resources."}
    if ($healthMetrics.MemoryUsage -gt 80) { $suggestions += "Consider closing unused applications or upgrading RAM."}
    foreach ($disk in $healthMetrics.DiskUsage) {
        if ($disk.FreeSpace -lt 20) {
            $suggestions += "Consider cleaning up disk space on drive $($disk.Drive)."
        }
    }

    return $suggestions
}

# Main execution 
$currentMetrics = Check-SystemHealth
$currentRating = Rate-SystemHealth - healthMetrics $currentMetrics

#Load last health check metrics if they exist