

Import-Module .\ActiveDirectoryStructure.psm1
Import-Module .\ManagedLANGroups.psm1
Import-Module .\passwordPolicyOveride.psm1
Import-Module .\createManagedLANDevices.psm1
Import-Module .\serverRoles.psm1
Import-Module .\managedLANRegistryKeys.psm1

#Checks if AD OU Stucture is in place
if (Get-ADStructure) {
    Write-Host "AD Structure in Place" -ForegroundColor Green
} else {
    Create-ADStructure
}

#Checks if the Managed LAN Security Groups Exist
if (Get-ManagedLANGroups) {
    Write-Host "Managed LAN Group Exist" -ForegroundColor Green
} else {
    Create-ManagedLANGroups
}

#Checks if the Managed LAN Password Policies Exist
if (Get-PasswordPolicy) {
    Write-Host "Password Policies Already Exist" -ForegroundColor Green
} else {
    Create-PasswordPolicy
}

#Create Managed LAN Users
Import-ManagedLANDevices

#Checks if the required Server Roles are installed. If not, it'll install it
if (Get-ManagedLANServerRoles) {
    Write-Host "AD CA and NPS Roles Previously Installed" -ForegroundColor Green
} else {
    Install-ManagedLANServerRoles
}

#Checks if NPS Registry Keys exist. If not, it'll create them
if (Get-ManagedLANRegistryKeys) {
    Write-Host "Registry Key and Entries Exist" -ForegroundColor Green
} else {
    Create-ManagedLANRegistryKeys
}