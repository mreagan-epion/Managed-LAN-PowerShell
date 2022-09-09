

Import-Module .\ActiveDirectoryStructure.psm1
if (Get-ADStructure) {
    Write-Host "AD Structure in Place"
}