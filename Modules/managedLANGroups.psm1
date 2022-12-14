

function Get-ManagedLANGroups {
    param()

    Import-Module ActiveDirectory

    $ManagedLANSecure="Managed_LAN_VLAN_1_Secure"
    $ManagedLANInternetOnly="Managed_LAN_VLAN_20_Internet_Only"
    $ManagedLANSecureExists = Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANSecure)"
    $ManagedLANInternetOnlyExists= Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANInternetOnly)"
    #Checks to see if Managed LAN Groups exists
    if ($ManagedLANSecureExists -eq $null) {
            return $false              
    }
    else {
        return $true
    } 
    if ($ManagedLANInternetOnlyExists -eq $null) {
            return $false
    }
    else {
        return $true
    } 
}

#Creates the Managed LAN Groups
#I also recognize there is a bug in the logic of the "main" script as to how it returns the $true message. Will work on that later. 
function Create-ManagedLANGroups {
    param()

    Import-Module ActiveDirectory
    Import-Module .\Modules\activeDirectoryStructure.psm1

    #Group Names
    $ManagedLANSecure="Managed_LAN_VLAN_1_Secure"
    $ManagedLANInternetOnly="Managed_LAN_VLAN_20_Internet_Only"

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
                -Path "OU=Managed_LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName" `
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
        Write-Host "Creating Internet Only Managed LAN Group" -ForegroundColor Yellow
        if (New-ADGroup `
                -Name "$ManagedLanInternetOnly" `
                -SamAccountName "$ManagedLanInternetOnly" `
                -GroupCategory Security `
                -GroupScope Global `
                -DisplayName "$ManagedLanInternetOnly" `
                -Path "OU=Managed_LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName" `
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
