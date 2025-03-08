Configuration WindowsServerSetup {
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName xDHCPServer
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource xFileServer 
    Import-DscResource xHyperV
}

Node "localhost" {
    # Install Active Directory Domain Services (AD DS)
    WindowsFeature ADDS {
        Name = "AD-Domain-Services"
        Ensure = "Present"
        Description = "Installs the Active Directory Domain Services role."
    }

    #Promote the server to a domain controller
    xADDomain FirstDS {
        DomainName = "corp.local"
        DomainAdministratorCredential = Get-Credential
        SafemodeAdministratorPassword = Get-Credential
        DependsOn = "[WindowsFeature]ADDS"
        Description = "Promotes the server to a domain controller."
    }

    # Configure DNS Forwarders
    xDNSServerForwarder Forwarder {
        IsSingleInstance = "Yes"
        Forwarders = @("8.8.8.8", "8.8.4.4")
        DependsOn = "[XADDomain]FirstDS"
        Description = "Configures DNS forwarders for external resolution."
    }
}