


# #Version 1.3
# #Developed By Corey and Matthew
# [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
# $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
# [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

# #Name of client/site.  This will pull from all sites of the client unless you specify the exact name of the client site in Unifi
# $Client = Read-Host "What is the UniFi Tenant Name?"

# #Prompts for password to connect to Unifi Controller.
# $password = Read-Host -assecurestring "Please enter the admin password for the Unifi Controller: "
# $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# #Filename of CSV export.
# $ExportFilename = "C:\Temp\TestMAC.csv"
# if (Test-Path $ExportFilename) { Remove-Item $ExportFilename; }
# New-Item $ExportFilename -ItemType "file" -Value "Mac address`r`n"

# #Unifi Controller IP/port with base API folder.
# $baseURI = "https://10.1.5.16:8443/api"

# #Login page for Unifi Controller
# $loginURI = "$baseURI/login"

# #Credentials to log into the Unifi Controller
# $cred = "`{`"username`":`"epion`",`"password`":`"$password`"`}"

# #Connecting to Unifi Controller and creating session
# Invoke-RestMethod -uri $loginURI -Method Post -Body $cred -ContentType "application/json" -SessionVariable session | out-null

# #Pulling list of sites on Unifi Controller and filtering by Client.
# $response = Invoke-RestMethod -Uri "$baseURI/self/sites" -Method Get  -WebSession $session
# $returnedSites = $response.data | select name,desc | where desc -like "*$Client*" | sort-object desc

# #Pulling list of client device mac addresses and exporting to a CSV file
# $finalresult = $returnedSites | select name,desc,@{n="devices";e={Invoke-RestMethod -Uri "$baseURI/s/$($_.name)/stat/sta" -Method Post -Body "" -WebSession $session}}
# ($finalresult.devices.data | where {$_.is_wired} | select mac | format-table -hidetableheaders | out-string).toupper().trim() | Out-File $ExportFilename -Append -Encoding ASCII
#CSV files with MACs that are related to either the Phones, Desktops, or Printers on the UniFi device list. 
$MyPath=Split-Path $MyInvocation.MyCommand.Path -Parent
$KnownDesktopMACs=Import-Csv -Path "$MyPath\KnownMACs\KnownMACs_Desktops.csv"
$KnownPhoneMACs=Import-Csv -Path "$MyPath\KnownMACs\KnownMACs_Phones.csv"
$KnownPrinterMACs=Import-Csv -Path "$MyPath\KnownMACs\KnownMACs_Printers.csv"
$KnownThinClientMACs=Import-Csv -Path "$MyPath\KnownMACs\KnownMACs_ThinClients.csv"
$KnownMiscMACs=Import-Csv -Path "$MyPath\KnownMACs\KnownMACs_Misc.csv"

#Filename and file path of CSV exports.
$UniFiExport="C:\Temp\TestMAC.csv"
$UnprocessedDesktopCSVPath="C:\Temp\UnDesktop.csv"
$UnprocessedPrinterCSVPath="C:\Temp\UnPrinter.csv"
$UnprocessedPhoneCSVPath="C:\Temp\UnPhone.csv"
$UnprocessedThinClientCSVPath="C:\Temp\UnThinClient.csv"
$UnprocessedMiscCSVPath="C:\Temp\UnMisc.csv"
$ProcessedDesktopCSV = "C:\Temp\Desktop.csv"
$ProcessedPhoneCSV = "C:\Temp\Phone.csv"
$ProcessedPrinterCSV = "C:\Temp\Printer.csv"
$ProcessedThinClientCSV = "C:\Temp\ThinClient.csv"
$ProcessedMiscCSV = "C:\Temp\Misc.csv"

#This deletes any existing UnProcessedDesktopCSV files to prevent duplicate data if a rerun is needed. 

if (Test-Path $UnProcessedDesktopCSVPath) { Remove-Item $UnProcessedDesktopCSVPath -ErrorAction SilentlyContinue; }
#New-Item $UnProcessedDesktopCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $UnProcessedPhoneCSVPath) { Remove-Item $UnProcessedPhoneCSVPath -ErrorAction SilentlyContinue; }
#New-Item $UnProcessedPhoneCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $UnProcessedPrinterCSVPath) { Remove-Item $UnProcessedPrinterCSVPath -ErrorAction SilentlyContinue; }
#New-Item $UnProcessedPrinterCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $UnProcessedThinClientCSVPath) { Remove-Item $UnProcessedThinClientCSVPath -ErrorAction SilentlyContinue; }
#New-Item $UnProcessedThinClientCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $UnProcessedMiscCSVPath) { Remove-Item $UnProcessedMiscCSVPath -ErrorAction SilentlyContinue; }
#New-Item $ProcessedMiscCSV -ItemType "file" -Value "Line`r`n"

#This deletes any existing ProcessedDesktopCSV files and recreates them.

if (Test-Path $ProcessedDesktopCSV) { Remove-Item $ProcessedDesktopCSV; }
New-Item $ProcessedDesktopCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $ProcessedPhoneCSV) { Remove-Item $ProcessedPhoneCSV; }
New-Item $ProcessedPhoneCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $ProcessedPrinterCSV) { Remove-Item $ProcessedPrinterCSV; }
New-Item $ProcessedPrinterCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $ProcessedThinClientCSV) { Remove-Item $ProcessedThinClientCSV; }
New-Item $ProcessedThinClientCSV -ItemType "file" -Value "Line`r`n"

if (Test-Path $ProcessedMiscCSV) { Remove-Item $ProcessedMiscCSV; }
New-Item $ProcessedMiscCSV -ItemType "file" -Value "Line`r`n"

#For Loops to sort all devices into there respective CSV files.
#Desktops
$KnownDesktopMACs | ForEach-Object{
                    Select-String `
                        -Path $UniFiExport `
                        -Pattern $($_.DesktopMACs) | Export-Csv `
                        -Path $UnprocessedDesktopCSVPath `
                        -Append                    
}
$UnprocessedDesktopCSV=import-csv -path 'C:\Temp\UnDesktop.csv'         
          
          $UnprocessedDesktopCSV | ForEach-Object{
                         $($_.line) -replace(":","")} | Out-File -Encoding ascii `
                         -FilePath $ProcessedDesktopCSV `
                         -Append            
#Phones
$KnownPhoneMACs | ForEach-Object{
                    Select-String `
                        -Path $UniFiExport `
                        -Pattern $($_.PhoneMACs) | Export-Csv `
                        -Path $UnprocessedPhoneCSVPath `
                        -Append
}
$UnprocessedPhoneCSV=import-csv -path 'C:\Temp\UnPhone.csv'         
          
          $UnprocessedPhoneCSV | ForEach-Object{
                         $($_.line) -replace(":","")} | Out-File -Encoding ascii `
                         -FilePath $ProcessedPhoneCSV `
                         -Append
#Printers
$KnownPrinterMACs | ForEach-Object{
                    Select-String `
                        -Path $UniFiExport `
                        -Pattern $($_.PrinterMACs) | Export-Csv `
                        -Path $UnprocessedPrinterCSVPath `
                        -Append
}
$UnprocessedPrinterCSV=import-csv -path 'C:\Temp\UnPrinter.csv'         
          
          $UnprocessedPrinterCSV | ForEach-Object{
                         $($_.line) -replace(":","")} | Out-File -Encoding ascii `
                         -FilePath $ProcessedPrinterCSV `
                         -Append
#Thin Clients
$KnownThinClientMACs | ForEach-Object{
                    Select-String `
                        -Path $UniFiExport `
                        -Pattern $($_.ThinClientMACs) | Export-Csv `
                        -Path $UnprocessedThinClientCSVPath `
                        -Append
}
$UnprocessedThinClientCSV=import-csv -path 'C:\Temp\UnThinClient.csv'         
          
          $UnprocessedThinClientCSV | ForEach-Object{
                         $($_.line) -replace(":","")} | Out-File -Encoding ascii `
                         -FilePath $ProcessedThinClientCSV `
                         -Append
#Misc Devices
$KnownMiscMACs | ForEach-Object{
                    Select-String `
                        -Path $UniFiExport `
                        -Pattern $($_.MiscMACs) | Export-Csv `
                        -Path $UnprocessedMiscCSVPath `
                        -Append
}
$UnprocessedMiscCSV=import-csv -path 'C:\Temp\UnMisc.csv'         
          
          $UnprocessedMiscCSV | ForEach-Object{
                         $($_.line) -replace(":","")} | Out-File -Encoding ascii `
                         -FilePath $ProcessedMiscCSV `
                         -Append

#Deleting the Unprocessed CSVs
Remove-Item $UnProcessedDesktopCSVPath
Remove-Item $UnProcessedPhoneCSVPath
Remove-Item $UnProcessedPrinterCSVPath
Remove-Item $UnProcessedThinClientCSVPath
Remove-Item $UnProcessedMiscCSVPath