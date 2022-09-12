

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
    Import-Module .\ActiveDirectoryStructure.psm1

    #Group Names
    $ManagedLANSecure="Managed LAN VLAN 1 - Secure"
    $ManagedLANInternetOnly="Managed LAN VLAN 20 - Internet Only"

    #Variable to put into the next couple of if statements
    $ManagedLANSecureExists = Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANSecure)"
    $ManagedLANInternetOnlyExists= Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANInternetOnly)"

    $domainPrefixName = Get-ADStructureName -suffixOrPrefix $true
    $domainSuffixName = Get-ADStructureName -suffixOrPrefix $false

    if ($ManagedLANSecureExists -eq $null) {
        Write-Host "Creating Secure Managed LAN Group" -ForegroundColor Yellow
        if (New-ADGroup `
                -Name "$ManagedLanSecure" `
                -SamAccountName "$ManagedLanSecure" `
                -GroupCategory Security `
                -GroupScope Global `
                -DisplayName "$ManagedLanSecure" `
                -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName" `
                -Description "This group is for authorized devices to connect to both the $domainSuffixName
                network and internet"
        ) {
            Write-Host "Error Creating the Managed LAN Secure Group. Please check the settings and try again. " -ForegroundColor Red
        } else {
            Write-Host "Successfully Created the Managed LAN Secure Group." -ForegroundColor Green
        }
    } else {
        Write-Host "Secure Managed LAN Group Exists" -ForegroundColor Green
    } 

    if ($ManagedLANInternetOnlyExists -eq $null) {
        Write-Host "Creating Internet Only Managed LAN Group"
        if (New-ADGroup `
                -Name "$ManagedLanInternetOnly" `
                -SamAccountName "$ManagedLanInternetOnly" `
                -GroupCategory Security `
                -GroupScope Global `
                -DisplayName "$ManagedLanInternetOnly" `
                -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName" `
                -Description "This group is for devices to only access the internet" 
        ) {
            Write-Host "Error Creating the Managed LAN Internet Only Group. Please check the settings and try again. " -ForegroundColor Red
        } else {
            Write-Host "Successfully Created the Managed LAN Internet Only Group." -ForegroundColor Green
        }
    } else {
        Write-Host "Internet Only Managed LAN Group Exists" -ForegroundColor Green
    } 
}
