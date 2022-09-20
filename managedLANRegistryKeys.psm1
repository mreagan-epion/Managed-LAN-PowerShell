


function Get-ManagedLANRegistryKeys {
    param()

    if (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4") {
        return $true
    } else {
        return $false
    }
}

function Create-ManagedLANRegistryKeys {
    param()

    if (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4") {
        Write-Host "Registry Key and Entries Exist" -ForegroundColor Green
    } else {
        Write-Host "Creating Registry Key and Entries" -ForegroundColor Yellow
        New-Item -path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP" -Name 4
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "RolesSupported" -PropertyType DWORD -Value "10"
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "InvokeUsername" -PropertyType DWORD -Value "1"
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "InvokePassword" -PropertyType DWORD -Value "1"
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "FriendlyName" -PropertyType String -Value "MD5-Challenge"
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "Path" -PropertyType ExpandString -Value "%SystemRoot%\System32\Raschap.dll"
    }
}