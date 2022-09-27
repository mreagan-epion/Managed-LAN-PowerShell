

#Imports the standard NPS configuration. It can sometimes fail
function Import-NPSConfig {
    param (
        [Parameter()]
        [string] $configPath = "..\NPSConfigimport.xml"
    )
    
    Import-NpsConfiguration -Path "$configPath"
    Write-Host "Standard NPS Policies have been created." -ForegroundColor Green
    Write-Host "You will need to add RADIUS Clients. Add Radius Clients now? y/n" -ForegroundColor Yellow
}

#Prompts the user to create RADIUS devices
function Create-RADIUSClients {
    param()

    $AddRadiusClientChoice=Read-Host

    do {
    if ($AddRadiusClientChoice -eq "n") {}
        else {
            Write-Host "Enter IP of Radius Client"
            $NPSRadiusUserInputIP=Read-Host
            Write-Host "Enter Name For Radius Host"
            $NPSRadiusUserInputName=Read-Host
            $NPSDefaultSharedSecret="Welcome1"
            Write-Host "Accept Default Shared Secret? "Welcome1" y/n"
            $NPSUserInputSharedSecretChoice=Read-Host

            if ($NPSUserInputSharedSecretChoice -eq "y") {
                New-NpsRadiusClient -Address $NPSRadiusUserInputIP -Name "$NPSRadiusUserInputName" -SharedSecret "$NPSDefaultSharedSecret"
            } else {
                Write-Host "Enter Shared Secret"
                $NPSUserInputSharedSecret=Read-Host
                New-NpsRadiusClient -Address $NPSRadiusUserInputIP -Name "$NPSRadiusUserInputName" -SharedSecret "$NPSUserInputSharedSecret"
            }
            Write-Host "Add Another Radius Client? y/n"
            $AddRadiusClientChoice=Read-Host
        }
    
    } until ($AddRadiusClientChoice -eq "n")

    Write-Host "Registry Keys and Standard NPS Policies have been created.  You will need to add the User Group to the 'Contrants' part of the policy for the appropriate Policy. If you didn't add RADIUS Clients you will also have to add those manually."

}