

Import-Module .\ActiveDirectoryStructure.psm1
Import-Module .\ManagedLANGroups.psm1
Import-Module .\passwordPolicyOveride.psm1
Import-Module .\createManagedLANDevices.psm1

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