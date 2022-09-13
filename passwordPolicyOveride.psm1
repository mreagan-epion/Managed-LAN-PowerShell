

function Get-PasswordPolicy {
    param()

    Import-Module ActiveDirectory

    if (Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO) {
        return $true
    } else {
        return $false
    }    

}

function Create-PasswordPolicy {
    param()

    Import-Module ActiveDirectory

    #Checks if password polcies for Managed LAN Accounts exist or not. If not, it creates them. 
    if (Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO) {
        Write-Host "Password Policies Already Exist" -ForegroundColor Green
    } else {
        Write-Host "Attempting to create Password Policies" -ForegroundColor Yellow
        try {
        New-ADFineGrainedPasswordPolicy -Name "ManagedLAN_PSO" -Precedence 100 -Description "The Managed LAN Password Policy" -DisplayName "Managed LAN PSO" -MinPasswordLength 12 -ReversibleEncryptionEnabled $true -ComplexityEnabled $false 
        Add-ADFineGrainedPasswordPolicySubject ManagedLAN_PSO -Subjects 'Managed LAN VLAN 1 - Secure' 
        Add-ADFineGrainedPasswordPolicySubject ManagedLAN_PSO -Subjects 'Managed LAN VLAN 20 - Internet Only'
        } catch {
            Write-Host "Failed to create Password Policies" -ForegroundColor Red
        }
    }

    if (Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO) {
        Write-Host "Password Policies Successfully Created" -ForegroundColor Green
    }
}
