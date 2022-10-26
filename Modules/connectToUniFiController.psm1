


function ConnectTo-UniFiController {
    param (
        # URI IP
        [Parameter(Mandatory)]
        [string] $URI
    )
    
    #Security Defaults
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

    #Unifi Controller IP/port with base API folder.
    $baseURI = "https://" + $URI + ":8443/api"

    #Login page for Unifi Controller
    $loginURI = "$baseURI/login"

    #Name of client/site.  This will pull from all sites of the client unless you specify the exact name of the client site in Unifi
    $client = Read-Host "What is the UniFi Tenant Name?"

    #Prompts for username
    $username = Read-Host "What is the username?"

    #Prompts for password to connect to Unifi Controller.
    $password = Read-Host -assecurestring "Please enter the admin password for the Unifi Controller: "
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    #Credentials to log into the Unifi Controller
    $cred = "`{`"username`":`"$username`",`"password`":`"$password`"`}"

    $connectionParameters = @($cred, $loginURI, $baseURI, $client)
    return $connectionParameters
}


function Export-Devices {
    param (
        # URI IP
        [Parameter(Mandatory)]
        [string] $URI
    )
    
    #Connecting to Unifi Controller and creating session
    $connectionParametersReturn = ConnectTo-UniFiController -URI $URI
    Invoke-RestMethod `
        -uri $($connectionParametersReturn[1]) `
        -Method Post `
        -Body $($connectionParametersReturn[0]) `
        -ContentType "application/json" `
        -SessionVariable session `
        | out-null

    $exportFilename = "C:\Temp\MACExport.csv"
    if (Test-Path $exportFilename) {
        Remove-Item $exportFilename
    }

    #Pulling list of sites on Unifi Controller and filtering by Client.
    $response = Invoke-RestMethod -Uri "$($connectionParametersReturn[2])/self/sites" -Method Get  -WebSession $session
    $returnedSites = $response.data | select name,desc | where desc -like "*$($connectionParametersReturn[3])*" | sort-object desc

    $finalresult = $returnedSites | select name,desc,@{n="devices";e={Invoke-RestMethod -Uri "$($connectionParametersReturn[2])/s/$($_.name)/stat/sta" -Method Post -Body "" -WebSession $session}}
    ($finalresult.devices.data | where {$_.is_wired} | select mac, hostname, oui) | Export-Csv -Path $exportFilename -Encoding ASCII -NoTypeInformation

    #Importing Un-Cleaned Data File
    $rawCSV = Import-Csv -Path $exportFilename
    #Placeholder for cleaned data
    $proccessedCSV = @()
    #Proccessing Raw Data
    $rawCSV | ForEach-Object {
        $proccessedCSV += [PSCustomObject]@{
            mac = $_.mac.toupper().trim() -replace(":", "")
            hostname = $_.hostname
            oui = $_.oui.replace(" ", "").replace(",", "").replace(".", "").replace("(", "").replace(")", "")
        }
    }
    if (Test-Path $exportFilename) {
        Remove-Item $exportFilename
    }
    $proccessedCSV | Export-Csv -Path $exportFilename -NoTypeInformation -Encoding ASCII
}