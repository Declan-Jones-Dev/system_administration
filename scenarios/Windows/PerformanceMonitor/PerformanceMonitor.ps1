# Script parameters

# Region Functions

function Write-Log {
    # Write log message to console and log file
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,

        [Parameter(Mandatory=$false)]
        [ValidateSet("INFO", "WARNING", "ERROR", "SUCCESS")]
        [string]$Level = $INFO 
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"

    # Create log directory if it doesn't exist
    $logDir = Join-Path $ReportPath "Logs"
    if (!(Test-Path $logDir)) {
        New-Item -Path $logDir -ItemType Directory -Force | Out-Null
    }

    $logFile = Join-Path $logDir ("PerformanceMonitor_" + (Get-Date -Format "yyyyMMdd") + ".log")

    # Set console color based on level
    switch ($Level) {
        "INFO" { $color = "White"; break}
        "WARNING" { $color = "Yellow"; break}
        "ERROR" {$color = "Red"; break}
        "SUCCESS" {$color = "Green"; break}
    }
}