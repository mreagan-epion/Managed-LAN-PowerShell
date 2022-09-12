

function Get-ManagedLANGroups {
    param()

    Import-Module ActiveDirectory

    $ManagedLANSecure="Managed LAN VLAN 1 - Secure"
    $ManagedLANInternetOnly="Managed LAN VLAN 20 - Internet Only"
    $ManagedLANSecureExists = Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANSecure)"
    $ManagedLANInternetOnlyExists= Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANInternetOnly)"
    #Checks to see if Managed LAN Groups exists
    if ($ManagedLANSecureExists -eq $null) {
            return $false              
    }
    else {
        Write-Host "Secure Managed LAN Group Exists" -ForegroundColor Green
    } 
    if ($ManagedLANInternetOnlyExists -eq $null) {
            return $false
    }
    else {
        Write-Host "Internet Only Managed LAN Group Exists" -ForegroundColor Green
    } 
}

function Create-ManagedLANGroups {
    param()

    Import-Module ActiveDirectory

    $ManagedLANSecure="Managed LAN VLAN 1 - Secure"
    $ManagedLANInternetOnly="Managed LAN VLAN 20 - Internet Only"
    $ManagedLANSecureExists = Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANSecure)"
    $ManagedLANInternetOnlyExists= Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANInternetOnly)"

    if ($ManagedLANSecureExists -eq $null) {
        Write-Host "Creating Secure Managed LAN Group" -ForegroundColor Yellow `
        New-ADGroup `
        -Name "$ManagedLanSecure" `
        -SamAccountName "$ManagedLanSecure" `
        -GroupCategory Security `
        -GroupScope Global `
        -DisplayName "$ManagedLanSecure" `
        -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName" `
        -Description "This group is for authorized devices to connect to both the $DomainSuffixName
        network and internet" `
        if ($ManagedLANSecureExists -eq $null) {
            Write-Host "Error Creating the Managed LAN Secure Group. Please check the settings and try again. " -ForegroundColor Red
        } else {
            Write-Host "Successfully Created the Managed LAN Secure Group." -ForegroundColor Green
        }
    } else {
        Write-Host "Secure Managed LAN Group Exists"
    } 

    if ($ManagedLANInternetOnlyExists -eq $null) {
            Write-Host "Creating Internet Only Managed LAN Group" `
            New-ADGroup `
            -Name "$ManagedLanInternetOnly" `
            -SamAccountName "$ManagedLanInternetOnly" `
            -GroupCategory Security `
            -GroupScope Global `
            -DisplayName "$ManagedLanInternetOnly" `
            -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName" `
            -Description "This group is for devices to only access the internet"
            if ($ManagedLANInternetOnlyExists -eq $null) {
                Write-Host "Error Creating the Managed LAN Internet Only Group. Please check the settings and try again. " -ForegroundColor Red
            } else {
                Write-Host "Successfully Created the Managed LAN Internet Only Group." -ForegroundColor Green
            }
    } else {
        Write-Host "Internet Only Managed LAN Group Exists"
    } 
}
