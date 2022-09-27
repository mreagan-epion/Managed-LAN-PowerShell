


function Get-ManagedLANServerRoles {
    param()

    Import-Module ActiveDirectory

    if ((Get-WindowsFeature | where name -eq AD-Certificate).installstate -eq "Installed" -and (Get-WindowsFeature | where name -eq npas).installstate -eq "Installed") {
        return $true
    } else {
        return $false
    }

}

function Install-ManagedLANServerRoles {
    param ()
    
    Import-Module ActiveDirectory

    if ((Get-WindowsFeature | where name -eq AD-Certificate).installstate -eq "Installed") {
        Write-Host "AD CA Role Previously Installed" -ForegroundColor Green
    } else {
        Write-Host "Installing and Configuring AD CA Role..." -ForegroundColor Yellow
        Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
        Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
        Install-AdcsCertificationAuthority -CAType StandaloneRootCa -Force
    }

    if ((Get-WindowsFeature | where name -eq npas).installstate -eq "Available") {
        Write-Host "Installing NPAS Role" 
        Install-WindowsFeature -Name "NPAS" -IncludeManagementTools
    }
}