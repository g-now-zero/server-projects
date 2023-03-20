<#-- This script installs AD DS on the server, creates a new forest, 
configures various settings for the new forest, and installs DNS. The 
parameters that are used with the Install-ADDSForest cmdlet specify 
various settings for the new forest, such as the domain name, NetBIOS 
name, and functional level. --#> 

<#-- imports the ADDSDeployment module into the PowerShell session, which 
provides the cmdlets needed to deploy AD DS, then installs AD DS and 
creates a new forest on the server, specifies path, sets domain 
functional level, specifies FQDN "gdomain.com", specifies NetBIOS name for 
the forest, then specifies whether to install DNS (set to $true, so it 
will), set path for ADDS log files to be stored, then specifies not to 
reboot after installation, then specifies path where ADDS Sysvol files 
will be stored, finally specifies to force the installation even if there 
are warnings or errors --#>

Import-ModuleADDSDeployment 
Install-ADDSForest -CreateDnsDelegation:$false
-DatabasePath "C: \Windows \NTDS"
-DomainMode "WinThreshold"
-DomainName "gdomain.com"
-DomainNetbiosName "GDOMAIN"
-ForestMode "WinThreshold"
-InstallDns:$true
-LogPath "C: \Windows NTDS"
-NoRebootOnCompletion:$false
-SysvolPath "C: \Windows\ SYSVOL"
-Force: $true

