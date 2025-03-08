<#Verify IP Configuration#>

ipconfig /all

Get-NetIPAddress | Format-Table InterfaceAlias, IPAddress, PrefixLength, AddressFamily

ipconfig /release
ipconfig /renew


<#Test Connectivity#>
#Using ping to test external and internal connectivity

ping 8.8.8.8 # Test external connectivity (Google DNS)
ping 127.0.0.1 # Test local connectivity (localhost)
ping www.google.com # Test DNS resolution

# Tracert used to check the route traffic takes to a destination
# Used to identify where the connection breaks

tracert 8.8.8.8 # Test external connectivity (Google DNS)
tracert www.google.com # Test DNS resolution

# Using NetConnection to test connectivity
Get-NetConnection

#Checks both DNS resolution and port accessibility
Test-NetConnection -ComputerName www.google.com -Port 80

# Check if specific ports are open

Test-NetConnection -ComputerName $server_ip -Port 443

<#Analyze DNS settings#>

# Check DNS server settings
Get-DnsClientDiagnostics
Get-DnsClientDohServerAddress

# Check the DNS server configuration
Get-DnsClientDiagnostics | Select-Object -ExpandProperty DnsServerAddress | Select-Object InterfaceAlias, ServerAddresses

# If DNS is misconfigured, update it manually
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddress ("8.8.8.8", "8.8.4.4")

<#Inspect Firewall Rules#>

Get-NetFirewallRule | Where-Object { $_.Enabled -eq $true} && Set-NetFirewalProfile -Profile Domain, Public, Private -Enabled False && Get-NetConnection

Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True && Get-NetConnection && Get-NetTCPConnection