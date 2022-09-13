


#This checks if the Managed LAN Polcies exist, if not, the error message will be captured into the POLICYERROROUTPUT Variable. 
$POLICYERROROUTPUT
try {
    Invoke-Expression "Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO" -ErrorVariable POLICYERROROUTPUT
} catch {

}

function Get-PasswordPolicy {
    param()

    Import-Module ActiveDirectory

    if ($POLICYERROROUTPUT -contains "Cannot find an object with identity: 'ManagedLAN_PSO'") {
        return $true
    } else {
        return $false
    }    

}

function Create-PasswordPolicy {
    param()

    Import-Module ActiveDirectory

    #Checks if password polcies for Managed LAN Accounts exist or not. If not, it creates them. 
    try {
        Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO
    } catch {
        New-ADFineGrainedPasswordPolicy `
            -Name "ManagedLAN_PSO" `
            -Precedence 100 `
            -Description "The Managed LAN Password Policy" `
            -DisplayName "Managed LAN PSO" `
            -MinPasswordLength 12 `
            -ReversibleEncryptionEnabled $true `
            -ComplexityEnabled $false 
        Add-ADFineGrainedPasswordPolicySubject `
            ManagedLAN_PSO `
            -Subjects 'Managed LAN VLAN 1 - Secure' 
        Add-ADFineGrainedPasswordPolicySubject `
            ManagedLAN_PSO `
            -Subjects 'Managed LAN VLAN 20 - Internet Only'
    }

    #Checks to make sure the Policies were created
    if ($POLICYERROROUTPUT -contains "Cannot find an object with identity: 'ManagedLAN_PSO'") {
        Write-Host "Password Policies Successfully Created" -ForegroundColor Green
    } else {
        Write-Host "Failed to Create Password Policies" -ForegroundColor Red
    }
}
