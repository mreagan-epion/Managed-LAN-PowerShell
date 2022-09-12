

Import-Module .\ActiveDirectoryStructure.psm1
Import-Module .\ManagedLANGroups.psm1

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