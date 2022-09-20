#Version 1.5.3
#Developed By Corey and Matthew
#the active directory module allows us to create AD accounts and groups
# Import-Module activedirectory
# #General Variables
# $CTemp="C:\Temp"
# #Sorted Device CSV List
# $DesktopUserAccounts=import-csv "$CTemp\Desktop.csv"
# $PhoneUserAccounts=import-csv "$CTemp\Phone.csv"
# $PrinterUserAccounts=import-csv "$CTemp\Printer.csv"
# $ThinClientUserAccounts=import-csv "$CTemp\ThinClient.csv"
# $MiscUserAccounts=import-csv "$CTemp\Misc.csv"
# #AD Structure
# $DomainPrefixName=(Get-ADDomain).name
# $DomainSuffixName="local" #Can be changed to "net", "biz", "com", etc
# #Creating OU structure if it doesn't exist
# #EpiOn OU
# if ([adsi]::Exists("LDAP://OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'EpiOn OU Exists'}
# else {Write-Host 'Creating EpiOn OU'
# New-ADOrganizationalUnit -Name 'EpiOn' -Path "DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Managed LAN OU
# if ([adsi]::Exists("LDAP://OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Managed LAN OU Exists'}
# else {Write-Host 'Creating Managed LAN OU'
# New-ADOrganizationalUnit -Name 'Managed LAN' -Path "OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Desktop OU
# if ([adsi]::Exists("LDAP://OU=Desktops,OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Desktops OU Exists'}
# else {Write-Host 'Creating Desktops OU'
# New-ADOrganizationalUnit -Name 'Desktops' -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Phone OU
# if ([adsi]::Exists("LDAP://OU=Phones,OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Phones OU Exists'}
# else {Write-Host 'Creating Phones OU'
# New-ADOrganizationalUnit -Name 'Phones' -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Printer OU
# if ([adsi]::Exists("LDAP://OU=Printers,OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Printers OU Exists'}
# else {Write-Host 'Creating Printers OU'
# New-ADOrganizationalUnit -Name 'Printers' -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Thin Client OU
# if ([adsi]::Exists("LDAP://OU=Thin Clients,OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Thin Clients OU Exists'}
# else {Write-Host 'Creating Thin Clients OU'
# New-ADOrganizationalUnit -Name 'Thin Clients' -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}
# #Misc OU
# if ([adsi]::Exists("LDAP://OU=Misc,OU=Managed LAN,OU=epion,DC=$DomainPrefixName,DC=$DomainSuffixName")) {Write-Host 'Misc OU Exists'}
# else {Write-Host 'Creating Misc OU'
# New-ADOrganizationalUnit -Name 'Misc' -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"}

# $DesktopOUPath="OU=Desktops,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
# $PhonesOUPath="OU=Phones,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
# $PrintersOUPath="OU=Printers,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
# $ThinClientsOUPath="OU=Thin Clients,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
# $MiscOUPath="OU=Misc,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"

# $ManagedLANSecure="Managed LAN VLAN 1 - Secure"
# $ManagedLANInternetOnly="Managed LAN VLAN 20 - Internet Only"
# $ManagedLANSecureExists = Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANSecure)"
# $ManagedLANInternetOnlyExists= Get-ADGroup -LDAPFilter "(SAMAccountName=$ManagedLANInternetOnly)"
# #Checks to see if Managed LAN Groups exists
# if ($ManagedLANSecureExists -eq $null) {Write-Host "Creating Secure Managed LAN Group"
#     New-ADGroup `
#         -Name "$ManagedLanSecure" `
#         -SamAccountName "$ManagedLanSecure" `
#         -GroupCategory Security `
#         -GroupScope Global `
#         -DisplayName "$ManagedLanSecure" `
#         -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName" `
#         -Description "This group is for authorized devices to connect to both the $DomainSuffixName
# 	 network and internet"
#         }
# else {Write-Host "Secure Managed LAN Group Exists"} 
# if ($ManagedLANInternetOnlyExists -eq $null) {Write-Host "Creating Internet Only Managed LAN Group"
#     New-ADGroup `
#         -Name "$ManagedLanInternetOnly" `
#         -SamAccountName "$ManagedLanInternetOnly" `
#         -GroupCategory Security `
#         -GroupScope Global `
#         -DisplayName "$ManagedLanInternetOnly" `
#         -Path "OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName" `
#         -Description "This group is for devices to only access the internet"
#         }
# else {Write-Host "Internet Only Managed LAN Group Exists"} 

# #Default Security Group Assignments
# $DesktopGroup=Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
# $PhoneGroup=Get-ADGroup "Managed LAN VLAN 20 - Internet Only" -Properties @("PrimaryGroupToken")
# $PrinterGroup=Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
# $ThinClientGroup=Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
# $MiscGroup=Get-ADGroup "Managed LAN VLAN 20 - Internet Only" -Properties @("PrimaryGroupToken")

# $DesktopCSVLine=$DesktopUserAccounts
# $DesktopOU=$DesktopOUPath
# $PhoneCSVLine=$PhoneUserAccounts
# $PhoneOU=$PhonesOUPath
# $PrinterCSVLine=$PrinterUserAccounts
# $PrinterOU=$PrintersOUPath
# $ThinClientCSVLine=$ThinClientUserAccounts
# $ThinClientOU=$ThinClientOUPath
# $MiscCSVLine=$MiscUserAccounts
# $MiscOU=$MiscOUPath

# $DomainName = (Get-WmiObject Win32_ComputerSystem).Domain

# $DomainUPN="@$DomainName"
# $DomainServer=(Get-ADDomain).PDCEmulator
# #Checks for and creates the Managed LAN PSO policy and apply it to the Managed LAN Security Groups
# try {
#     Get-ADFinegrainedPasswordPolicy ManagedLAN_PSO
# } catch {
#     New-ADFineGrainedPasswordPolicy -Name "ManagedLAN_PSO" -Precedence 100 -Description "The Managed LAN Password Policy" -DisplayName "Managed LAN PSO" -MinPasswordLength 12 -ReversibleEncryptionEnabled $true -ComplexityEnabled $false 
#     Add-ADFineGrainedPasswordPolicySubject ManagedLAN_PSO -Subjects 'Managed LAN VLAN 1 - Secure' 
#     Add-ADFineGrainedPasswordPolicySubject ManagedLAN_PSO -Subjects 'Managed LAN VLAN 20 - Internet Only'
# }
# #The next 5 loops create the user, sets the username and password as the MAC address, stores the password with reversible encryption, adds it the its respective group, sets that group as 
# #primary, and removes it from the Domain Users group.

# #Desktops
#             $DesktopCSVLine | ForEach-Object{
#             if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
#                 "Desktop User Account '$($_.Line)' Exists Already"}
#             else {
#             Write-Host "Creating Desktop User '$($_.Line)'"
#             New-ADUser `
#                 -Server $DomainServer `
#                 -Name $($_.line) `
#                 -Path "$DesktopOU" `
#                 -UserPrincipalName "$($_.line)$DomainUPN" `
#                 -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
#                 -Enabled $true `
#                 -PasswordNeverExpires $true `
#                 -AllowReversiblePasswordEncryption $true 
                           
#             Add-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "$DesktopGroup" `
#                 -Members $($_.line)

#             Get-ADUser `
#                 -Server $DomainServer `
#                 -identity $($_.line) | Set-ADUser `
#                 -Server $DomainServer `
#                 -Replace @{primarygroupid=$DesktopGroup.primarygrouptoken}

#             Remove-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "Domain Users" `
#                 -Members "$($_.line)" `
#                 -confirm:$false

#             Set-ADAccountPassword `
#                 -Server $DomainServer `
#                 -Identity $($_.line) `
#                 -NewPassword (ConvertTo-SecureString `
#                     -AsPlainText $($_.Line) `
#                     -Force) `
#                     -Reset `
# }}
# #Phones
#             $PhoneCSVLine | ForEach-Object{
#             if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
#                 "Phone User Account '$($_.Line)' Exists Already"}
#             else {
#             Write-Host "Creating Phone User '$($_.Line)'"
#             New-ADUser `
#                 -Server $DomainServer `
#                 -Name $($_.line) `
#                 -Path "$PhoneOU" `
#                 -UserPrincipalName "$($_.line)$DomainUPN" `
#                 -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
#                 -Enabled $true `
#                 -PasswordNeverExpires $true `
#                 -AllowReversiblePasswordEncryption $true 
                           
#             Add-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "$PhoneGroup" `
#                 -Members $($_.line)

#             Get-ADUser `
#                 -Server $DomainServer `
#                 -identity $($_.line) | Set-ADUser `
#                 -Server $DomainServer `
#                 -Replace @{primarygroupid=$PhoneGroup.primarygrouptoken}

#             Remove-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "Domain Users" `
#                 -Members "$($_.line)" `
#                 -confirm:$false

#             Set-ADAccountPassword `
#                 -Server $DomainServer `
#                 -Identity $($_.line) `
#                 -NewPassword (ConvertTo-SecureString `
#                     -AsPlainText $($_.Line) `
#                     -Force) `
#                     -Reset `
# }}
# #Printers
#             $PrinterCSVLine | ForEach-Object{
#             if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
#                 "Printer User Account '$($_.Line)' Exists Already"}
#             else {
#             Write-Host "Creating Printer User '$($_.Line)'"
#             New-ADUser `
#                 -Server $DomainServer `
#                 -Name $($_.line) `
#                 -Path "$PrinterOU" `
#                 -UserPrincipalName "$($_.line)$DomainUPN" `
#                 -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
#                 -Enabled $true `
#                 -PasswordNeverExpires $true `
#                 -AllowReversiblePasswordEncryption $true 
                           
#             Add-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "$PrinterGroup" `
#                 -Members $($_.line)

#             Get-ADUser `
#                 -Server $DomainServer `
#                 -identity $($_.line) | Set-ADUser `
#                 -Server $DomainServer `
#                 -Replace @{primarygroupid=$PrinterGroup.primarygrouptoken}

#             Remove-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "Domain Users" `
#                 -Members "$($_.line)" `
#                 -confirm:$false

#             Set-ADAccountPassword `
#                 -Server $DomainServer `
#                 -Identity $($_.line) `
#                 -NewPassword (ConvertTo-SecureString `
#                     -AsPlainText $($_.Line) `
#                     -Force) `
#                     -Reset `
# }}
# #Thin Clients
#             $ThinClientCSVLine | ForEach-Object{
#             if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
#                 "Thin Client User Account '$($_.Line)' Exists Already"}
#             else {
#             Write-Host "Creating Thin Client User '$($_.Line)'"
#             New-ADUser `
#                 -Server $DomainServer `
#                 -Name $($_.line) `
#                 -Path "$ThinClientOU" `
#                 -UserPrincipalName "$($_.line)$DomainUPN" `
#                 -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
#                 -Enabled $true `
#                 -PasswordNeverExpires $true `
#                 -AllowReversiblePasswordEncryption $true 
                           
#             Add-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "$ThinClientGroup" `
#                 -Members $($_.line)

#             Get-ADUser `
#                 -Server $DomainServer `
#                 -identity $($_.line) | Set-ADUser `
#                 -Server $DomainServer `
#                 -Replace @{primarygroupid=$ThinClientGroup.primarygrouptoken}

#             Remove-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "Domain Users" `
#                 -Members "$($_.line)" `
#                 -confirm:$false

#             Set-ADAccountPassword `
#                 -Server $DomainServer `
#                 -Identity $($_.line) `
#                 -NewPassword (ConvertTo-SecureString `
#                     -AsPlainText $($_.Line) `
#                     -Force) `
#                     -Reset `
# }}
# #Misc Devices
#             $MiscCSVLine | ForEach-Object{
#             if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
#                 "Misc User Account '$($_.Line)' Exists Already"}
#             else {
#             Write-Host "Creating Misc User '$($_.Line)'"
#             New-ADUser `
#                 -Server $DomainServer `
#                 -Name $($_.line) `
#                 -Path "$MiscOU" `
#                 -UserPrincipalName "$($_.line)$DomainUPN" `
#                 -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
#                 -Enabled $true `
#                 -PasswordNeverExpires $true `
#                 -AllowReversiblePasswordEncryption $true 
                           
#             Add-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "$MiscGroup" `
#                 -Members $($_.line)

#             Get-ADUser `
#                 -Server $DomainServer `
#                 -identity $($_.line) | Set-ADUser `
#                 -Server $DomainServer `
#                 -Replace @{primarygroupid=$MiscGroup.primarygrouptoken}

#             Remove-ADGroupMember `
#                 -Server $DomainServer `
#                 -identity "Domain Users" `
#                 -Members "$($_.line)" `
#                 -confirm:$false

#             Set-ADAccountPassword `
#                 -Server $DomainServer `
#                 -Identity $($_.line) `
#                 -NewPassword (ConvertTo-SecureString `
#                     -AsPlainText $($_.Line) `
#                     -Force) `
#                     -Reset `
# }}

# if ((Get-WindowsFeature | where name -eq AD-Certificate).installstate -eq "Installed") {
#     write-host "AD CA Role Installed"}
#     else {Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
#             Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
#             Install-AdcsCertificationAuthority -CAType StandaloneRootCa -Force}
# #Installing Network Policy Role and Starts IF statement to decide whether or not to create the MD5 Reg Keys
# if ((Get-WindowsFeature | where name -eq npas).installstate -eq "Available") {
# Write-Host "Installing NPAS Role" 
# Install-WindowsFeature -Name "NPAS" -IncludeManagementTools
#Creates MD5 Registry Keys
# if (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4") {Write-Host "Registry Key and Entries Exist"}
# else {
# 	Write-Host "Creating Registry Key and Entries"
# 	New-Item -path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP" -Name 4
# 	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "RolesSupported" -PropertyType DWORD -Value "10"
# 	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "InvokeUsername" -PropertyType DWORD -Value "1"
# 	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "InvokePassword" -PropertyType DWORD -Value "1"
# 	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "FriendlyName" -PropertyType String -Value "MD5-Challenge"
# 	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\4" -Name "Path" -PropertyType ExpandString -Value "%SystemRoot%\System32\Raschap.dll"
# }
#Create the NPS Template
# $NPSTemplate="NPSConfigImport.xml"
# $NPSTemplatePath="$CTemp\$NPSTemplate"
# if (Test-Path $NPSTemplatePath) { Remove-Item $NPSTemplatePath; }
# New-Item -Path "C:\users\mreagan\Downloads" -Name "$NPSTemplate" -ItemType "file" -Value '<?xml version="1.0"?>
# <Root xmlns:dt="urn:schemas-microsoft-com:datatypes">
# 	<_locDefinition>
# 		<_locDefault _loc="locNone"/>
# 		<_locDefaultAttr _loc="locNone"/>
# 		<_locTag _loc="locNone" _locAttrData="name">Connections_to_other_access_servers</_locTag>
# 		<_locTag _loc="locNone" _locAttrData="name">Connections_to_Microsoft_Routing_and_Remote_Access_server</_locTag>
# 		<_locTag _loc="locNone" _locAttrData="name">Use_Windows_authentication_for_all_users</_locTag>
# 	</_locDefinition>
# 	<Children>
# 		<Version name="Version" dt:dt="int">257</Version>
# 		<TemplatesTimestamp name="TemplatesTimestamp" xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></TemplatesTimestamp>
# 		<Microsoft_Internet_Authentication_Service name="Microsoft_Internet_Authentication_Service">
# 			<Properties>
# 				<Description>NPS</Description>
# 			</Properties>
# 			<Children>
# 				<RadiusProfiles name="RadiusProfiles">
# 					<Children>
# 						<Connections_to_other_access_servers name="Connections to other access servers">
# 							<Properties><IP_Filter_Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</IP_Filter_Template_Guid><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAllowDialin xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">0</msNPAllowDialin><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">9</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">10</msNPAuthenticationType2><msRADIUSFramedProtocol xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msRADIUSFramedProtocol><msRADIUSServiceType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRADIUSServiceType></Properties></Connections_to_other_access_servers>
# 						<Connections_to_Microsoft_Routing_and_Remote_Access_server name="Connections to Microsoft Routing and Remote Access server">
# 							<Properties><IP_Filter_Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</IP_Filter_Template_Guid><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAllowDialin xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">0</msNPAllowDialin><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">1a000000000000000000000000000000</msNPAllowedEapType><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">0d000000000000000000000000000000</msNPAllowedEapType><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">5</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">10</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">9</msNPAuthenticationType2><msRADIUSFramedProtocol xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msRADIUSFramedProtocol><msRADIUSServiceType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRADIUSServiceType><msRASFilter xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">0100000048000000010000000100ffff2800000001000000200000000000000001000000010000000100000000000000000000000000000000000000000000000000000000000000</msRASFilter><msRASMPPEEncryptionPolicy xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRASMPPEEncryptionPolicy><msRASMPPEEncryptionType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">14</msRASMPPEEncryptionType></Properties></Connections_to_Microsoft_Routing_and_Remote_Access_server>
# 						<Secure_Wireless_Connections name="Secure Wireless Connections"><Properties><IP_Filter_Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</IP_Filter_Template_Guid><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msIgnoreUserDialinProperties xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">0</msIgnoreUserDialinProperties><msNPAllowDialin xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</msNPAllowDialin><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">19000000000000000000000000000000</msNPAllowedEapType><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">5</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">9</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">10</msNPAuthenticationType2><msRADIUSFramedProtocol xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msRADIUSFramedProtocol><msRADIUSServiceType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRADIUSServiceType></Properties></Secure_Wireless_Connections><Secure_Wired_Connections___Internet_Only_VLAN_20 name="Secure Wired Connections - Internet Only VLAN 20"><Properties><IP_Filter_Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</IP_Filter_Template_Guid><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAllowDialin xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</msNPAllowDialin><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">19000000000000000000000000000000</msNPAllowedEapType><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">04000000000000000000000000000000</msNPAllowedEapType><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">5</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">9</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">10</msNPAuthenticationType2><msRADIUSFramedProtocol xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msRADIUSFramedProtocol><msRADIUSServiceType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRADIUSServiceType><msRADIUSTunnelMediumType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">6</msRADIUSTunnelMediumType><msRADIUSTunnelPrivateGroupId xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">20</msRADIUSTunnelPrivateGroupId><msRADIUSTunnelType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">13</msRADIUSTunnelType><msRASBapLinednLimit xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">50</msRASBapLinednLimit><msRASBapLinednTime xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">120</msRASBapLinednTime></Properties></Secure_Wired_Connections___Internet_Only_VLAN_20><Secure_Wired_Connections___Secure_VLAN_1 name="Secure Wired Connections - Secure VLAN 1"><Properties><IP_Filter_Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</IP_Filter_Template_Guid><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAllowDialin xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</msNPAllowDialin><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">19000000000000000000000000000000</msNPAllowedEapType><msNPAllowedEapType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="bin.hex">04000000000000000000000000000000</msNPAllowedEapType><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">5</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">9</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPAuthenticationType2><msNPAuthenticationType2 xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">10</msNPAuthenticationType2><msRADIUSFramedProtocol xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msRADIUSFramedProtocol><msRADIUSServiceType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msRADIUSServiceType><msRADIUSTunnelMediumType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">6</msRADIUSTunnelMediumType><msRADIUSTunnelPrivateGroupId xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">1</msRADIUSTunnelPrivateGroupId><msRADIUSTunnelType xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">13</msRADIUSTunnelType></Properties></Secure_Wired_Connections___Secure_VLAN_1></Children>
# 				</RadiusProfiles><NetworkPolicy name="NetworkPolicy">
# 					<Children>
# 						<Connections_to_other_access_servers name="Connections to other access servers">
# 							<Properties><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Policy_Enabled xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</Policy_Enabled><Policy_SourceTag xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">0</Policy_SourceTag><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAction xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">Connections to other access servers</msNPAction><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">TIMEOFDAY("0 00:00-24:00; 1 00:00-24:00; 2 00:00-24:00; 3 00:00-24:00; 4 00:00-24:00; 5 00:00-24:00; 6 00:00-24:00")</msNPConstraint><msNPSequence xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">5</msNPSequence></Properties></Connections_to_other_access_servers>
# 						<Connections_to_Microsoft_Routing_and_Remote_Access_server name="Connections to Microsoft Routing and Remote Access server">
# 							<Properties><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Policy_Enabled xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</Policy_Enabled><Policy_SourceTag xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">0</Policy_SourceTag><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAction xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">Connections to Microsoft Routing and Remote Access server</msNPAction><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">MATCH("MS-RAS-Vendor=^311$")</msNPConstraint><msNPSequence xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">4</msNPSequence></Properties></Connections_to_Microsoft_Routing_and_Remote_Access_server>
# 						<Secure_Wireless_Connections name="Secure Wireless Connections"><Properties><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Policy_Enabled xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</Policy_Enabled><Policy_SourceTag xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">0</Policy_SourceTag><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAction xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">Secure Wireless Connections</msNPAction><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">USERNTGROUPS("S-1-5-21-3379388837-4248265286-4210970845-513")</msNPConstraint><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">MATCH("NAS-Port-Type=^19$")</msNPConstraint><msNPSequence xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">1</msNPSequence></Properties></Secure_Wireless_Connections><Secure_Wired_Connections___Internet_Only_VLAN_20 name="Secure Wired Connections - Internet Only VLAN 20"><Properties><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Policy_Enabled xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</Policy_Enabled><Policy_SourceTag xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">0</Policy_SourceTag><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAction xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">Copy of Secure Wired Connections - Internet Only VLAN 20</msNPAction><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">USERNTGROUPS("S-1-5-21-3379388837-4248265286-4210970845-2118")</msNPConstraint><msNPSequence xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">2</msNPSequence></Properties></Secure_Wired_Connections___Internet_Only_VLAN_20><Secure_Wired_Connections___Secure_VLAN_1 name="Secure Wired Connections - Secure VLAN 1"><Properties><Opaque_Data xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string"></Opaque_Data><Policy_Enabled xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="boolean">1</Policy_Enabled><Policy_SourceTag xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">0</Policy_SourceTag><Template_Guid xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">{00000000-0000-0000-0000-000000000000}</Template_Guid><msNPAction xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">Copy of Secure Wired Connections - Secure VLAN 1</msNPAction><msNPConstraint xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="string">USERNTGROUPS("S-1-5-21-3379388837-4248265286-4210970845-2119")</msNPConstraint><msNPSequence xmlns:dt="urn:schemas-microsoft-com:datatypes" dt:dt="int">3</msNPSequence></Properties></Secure_Wired_Connections___Secure_VLAN_1></Children>
# 				</NetworkPolicy><Proxy_Policies name="Proxy_Policies">
# 					<Children>
# 						<Use_Windows_authentication_for_all_users name="Use Windows authentication for all users">
# 							<Properties>
# 								<msNPAction _loc="locData" dt:dt="string">Use Windows authentication for all users</msNPAction>
# 								<msNPConstraint dt:dt="string">TIMEOFDAY("0 00:00-24:00; 1 00:00-24:00; 2 00:00-24:00; 3 00:00-24:00; 4 00:00-24:00; 5 00:00-24:00; 6 00:00-24:00")</msNPConstraint>
# 								<msNPSequence dt:dt="int">999999</msNPSequence>
# 							</Properties>
# 						</Use_Windows_authentication_for_all_users>
# 					</Children>
# 				</Proxy_Policies>
# 				<Proxy_Profiles name="Proxy_Profiles">
# 					<Children>
# 						<Use_Windows_authentication_for_all_users name="Use Windows authentication for all users">
# 							<Properties>
# 								<msAuthProviderType dt:dt="int">1</msAuthProviderType>
# 							</Properties>
# 						</Use_Windows_authentication_for_all_users>
# 					</Children>
# 				</Proxy_Profiles>
# 				<Protocols name="Protocols">
# 					<Children>
# 						<Microsoft_Protocol_Surrogate name="Microsoft Protocol Surrogate">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.IasHelper</Component_Prog_Id>
# 								<Component_Id dt:dt="int">262145</Component_Id>
# 							</Properties>
# 						</Microsoft_Protocol_Surrogate>
# 						<Microsoft_Radius_Protocol name="Microsoft Radius Protocol">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.RadiusProtocol</Component_Prog_Id>
# 								<Component_Id dt:dt="int">262144</Component_Id>
# 								<Authentication_Port dt:dt="string">1812,1645</Authentication_Port>
# 								<Accounting_Port dt:dt="string">1813,1646</Accounting_Port>
# 							</Properties>
# 							<Children>
# 								<Vendors name="Vendors">
# 									<Children>
# 										<RADIUS_Standard name="RADIUS Standard">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">0</NAS_Vendor_Id>
# 											</Properties>
# 										</RADIUS_Standard>
# 										<_Com name="3Com">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">43</NAS_Vendor_Id>
# 											</Properties>
# 										</_Com>
# 										<ACC name="ACC">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">5</NAS_Vendor_Id>
# 											</Properties>
# 										</ACC>
# 										<ADC_Kentrox name="ADC Kentrox">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">181</NAS_Vendor_Id>
# 											</Properties>
# 										</ADC_Kentrox>
# 										<Ascend_Communications_Inc_ name="Ascend Communications Inc.">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">529</NAS_Vendor_Id>
# 											</Properties>
# 										</Ascend_Communications_Inc_>
# 										<BBN name="BBN">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">14</NAS_Vendor_Id>
# 											</Properties>
# 										</BBN>
# 										<BinTec_Communications_GmbH name="BinTec Communications GmbH">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">272</NAS_Vendor_Id>
# 											</Properties>
# 										</BinTec_Communications_GmbH>
# 										<Cabletron_Systems name="Cabletron Systems">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">52</NAS_Vendor_Id>
# 											</Properties>
# 										</Cabletron_Systems>
# 										<Cisco name="Cisco">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">9</NAS_Vendor_Id>
# 											</Properties>
# 										</Cisco>
# 										<Digi_International name="Digi International">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">332</NAS_Vendor_Id>
# 											</Properties>
# 										</Digi_International>
# 										<EICON name="EICON">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">434</NAS_Vendor_Id>
# 											</Properties>
# 										</EICON>
# 										<Gandalf name="Gandalf">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">64</NAS_Vendor_Id>
# 											</Properties>
# 										</Gandalf>
# 										<Intel_Corporation name="Intel Corporation">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">343</NAS_Vendor_Id>
# 											</Properties>
# 										</Intel_Corporation>
# 										<Lantronix name="Lantronix">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">244</NAS_Vendor_Id>
# 											</Properties>
# 										</Lantronix>
# 										<Livingston_Enterprises__Inc_ name="Livingston Enterprises, Inc.">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">307</NAS_Vendor_Id>
# 											</Properties>
# 										</Livingston_Enterprises__Inc_>
# 										<Proteon name="Proteon">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">1</NAS_Vendor_Id>
# 											</Properties>
# 										</Proteon>
# 										<Shiva_Corporation name="Shiva Corporation">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">166</NAS_Vendor_Id>
# 											</Properties>
# 										</Shiva_Corporation>
# 										<Telebit name="Telebit">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">117</NAS_Vendor_Id>
# 											</Properties>
# 										</Telebit>
# 										<U_S__Robotics__Inc_ name="U.S. Robotics, Inc.">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">429</NAS_Vendor_Id>
# 											</Properties>
# 										</U_S__Robotics__Inc_>
# 										<Xylogics__Inc_ name="Xylogics, Inc.">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">15</NAS_Vendor_Id>
# 											</Properties>
# 										</Xylogics__Inc_>
# 										<Microsoft name="Microsoft">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">311</NAS_Vendor_Id>
# 											</Properties>
# 										</Microsoft>
# 										<RedBack_Networks name="RedBack Networks">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">2352</NAS_Vendor_Id>
# 											</Properties>
# 										</RedBack_Networks>
# 										<Nortel_Networks name="Nortel Networks">
# 											<Properties>
# 												<NAS_Vendor_Id dt:dt="int">562</NAS_Vendor_Id>
# 											</Properties>
# 										</Nortel_Networks>
# 									</Children>
# 								</Vendors>
# 								<Clients name="Clients">
# 									<Children>
# 									</Children></Clients></Children>
# 						</Microsoft_Radius_Protocol>
# 					</Children>
# 				</Protocols>
# 				<RequestHandlers name="RequestHandlers">
# 					<Children>
# 						<Microsoft_Network_Access_Policy_Evaluator name="Microsoft Network Access Policy Evaluator">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.PolicyEnforcer</Component_Prog_Id>
# 								<Component_Id dt:dt="int">7</Component_Id>
# 							</Properties>
# 						</Microsoft_Network_Access_Policy_Evaluator>
# 						<Microsoft_NT_SAM_Authentication name="Microsoft NT SAM Authentication">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.NTSamAuthentication</Component_Prog_Id>
# 								<Component_Id dt:dt="int">1</Component_Id>
# 								<Allow_LM_Authentication dt:dt="boolean">1</Allow_LM_Authentication>
# 							</Properties>
# 						</Microsoft_NT_SAM_Authentication>
# 						<Microsoft_Proxy_Policy_Evaluator name="Microsoft Proxy Policy Evaluator">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.ProxyPolicyEnforcer</Component_Prog_Id>
# 								<Component_Id dt:dt="int">5</Component_Id>
# 							</Properties>
# 						</Microsoft_Proxy_Policy_Evaluator>
# 						<Microsoft_RADIUS_Proxy name="Microsoft RADIUS Proxy">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.RadiusProxy</Component_Prog_Id>
# 								<Component_Id dt:dt="int">8</Component_Id>
# 							</Properties>
# 						</Microsoft_RADIUS_Proxy>
# 						<Microsoft_Accounting name="Microsoft Accounting">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.Accounting</Component_Prog_Id>
# 								<Component_Id dt:dt="int">9</Component_Id>
# 								<Delete_If_Full dt:dt="boolean">1</Delete_If_Full>
# 								<Log_Accounting_Packets dt:dt="boolean">1</Log_Accounting_Packets>
# 								<Log_Authentication_Packets dt:dt="boolean">1</Log_Authentication_Packets>
# 								<Log_Format dt:dt="int">65535</Log_Format>
# 								<Log_Interim_Accounting_Packets dt:dt="boolean">1</Log_Interim_Accounting_Packets>
# 								<Log_Interim_Authentication_Packets dt:dt="boolean">1</Log_Interim_Authentication_Packets>
# 								<New_Log_Frequency dt:dt="int">3</New_Log_Frequency>
# 								<New_Log_Size dt:dt="int">10</New_Log_Size>
# 								<Log_File_Is_Backup dt:dt="boolean">0</Log_File_Is_Backup>
# 								<Discard_On_Failure dt:dt="boolean">1</Discard_On_Failure>
# 							</Properties>
# 						</Microsoft_Accounting>
# 						<Microsoft_Database_Accounting name="Microsoft Database Accounting">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.DatabaseAccounting</Component_Prog_Id>
# 								<Component_Id dt:dt="int">13</Component_Id>
# 								<Log_Accounting_Packets dt:dt="boolean">1</Log_Accounting_Packets>
# 								<Log_Authentication_Packets dt:dt="boolean">1</Log_Authentication_Packets>
# 								<Log_Interim_Accounting_Packets dt:dt="boolean">1</Log_Interim_Accounting_Packets>
# 								<Log_Interim_Authentication_Packets dt:dt="boolean">1</Log_Interim_Authentication_Packets>
# 								<SQL_Max_Sessions dt:dt="int">20</SQL_Max_Sessions>
# 								<Discard_On_Failure dt:dt="boolean">1</Discard_On_Failure>
# 							</Properties>
# 						</Microsoft_Database_Accounting>
# 					</Children>
# 				</RequestHandlers>
# 				<Auditors name="Auditors">
# 					<Children>
# 						<Microsoft_NT_Event_Log_Auditor name="Microsoft NT Event Log Auditor">
# 							<Properties>
# 								<Component_Prog_Id dt:dt="string">IAS.NTEventLog</Component_Prog_Id>
# 								<Component_Id dt:dt="int">524288</Component_Id>
# 								<Log_Application_Events dt:dt="boolean">1</Log_Application_Events>
# 								<Log_Malformed_Packets dt:dt="boolean">1</Log_Malformed_Packets>
# 								<Log_Verbose dt:dt="boolean">1</Log_Verbose>
# 							</Properties>
# 						</Microsoft_NT_Event_Log_Auditor>
# 					</Children>
# 				</Auditors>
# 				<RADIUS_Server_Groups name="RADIUS_Server_Groups">
# 					<Children>
# 					</Children>
# 				</RADIUS_Server_Groups>
# 			</Children>
# 		</Microsoft_Internet_Authentication_Service>
# 		<SDO_Schema name="SDO_Schema">
# 			<Children>
# 				<SDO_Schema_Classes name="SDO_Schema_Classes">
# 					<Children>
# 						<Client_SDO name="Client_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoClient</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Require_Signature</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Shared_Secret</RequiredProperties>
# 								<RequiredProperties dt:dt="string">NAS_Manufacturer</RequiredProperties>
# 								<RequiredProperties dt:dt="string">IP_Address</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Radius_Client_Enabled</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Client_Secret_Template_Guid</OptionalProperties>
# 							</Properties>
# 						</Client_SDO>
# 						<Condition_SDO name="Condition_SDO">
# 							<Properties>
# 								<ClassId>IAS.SdoCondition</ClassId>
# 								<RequiredProperties dt:dt="string">Condition_Text</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 							</Properties>
# 						</Condition_SDO>
# 						<Policy_SDO name="Policy_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoPolicy</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">msNPConstraint</RequiredProperties>
# 								<RequiredProperties dt:dt="string">msNPSequence</RequiredProperties>
# 								<RequiredProperties dt:dt="string">msNPAction</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Policy_Action</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Conditions</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Policy_Enabled</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Policy_SourceTag</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 							</Properties>
# 						</Policy_SDO>
# 						<Profile_SDO name="Profile_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoProfile</ClassId>
# 								<RequiredProperties dt:dt="string">Profile_Attributes</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 								<OptionalProperties dt:dt="string">IP_Filter_Template_Guid</OptionalProperties>
# 							</Properties>
# 						</Profile_SDO>
# 						<Microsoft_NT_Event_Log_SDO name="Microsoft_NT_Event_Log_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.NTEventLog</ClassId>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Application_Events</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Malformed_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Verbose</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 							</Properties>
# 						</Microsoft_NT_Event_Log_SDO>
# 						<Microsoft_Network_Access_Policy_Evaluator_SDO name="Microsoft_Network_Access_Policy_Evaluator_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.PolicyEnforcer</ClassId>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">NAP_Policies</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 							</Properties>
# 						</Microsoft_Network_Access_Policy_Evaluator_SDO>
# 						<Microsoft_NT_SAM_Authentication_SDO name="Microsoft_NT_SAM_Authentication_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.NTSamAuthentication</ClassId>
# 								<OptionalProperties dt:dt="string">Allow_LM_Authentication</OptionalProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 							</Properties>
# 						</Microsoft_NT_SAM_Authentication_SDO>
# 						<Microsoft_Accounting_SDO name="Microsoft_Accounting_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.Accounting</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Accounting_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Interim_Accounting_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Authentication_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">New_Log_Frequency</RequiredProperties>
# 								<RequiredProperties dt:dt="string">New_Log_Size</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_File_Directory</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Format</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Delete_If_Full</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Log_Interim_Authentication_Packets</OptionalProperties>
# 								<RequiredProperties dt:dt="string">Log_File_Is_Backup</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Discard_On_Failure</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 							</Properties>
# 						</Microsoft_Accounting_SDO>
# 						<IAS_SDO name="IAS_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoServiceIAS</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Description</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Policies</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Profiles</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Protocols</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Auditors</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Request_Handlers</RequiredProperties>
# 								<RequiredProperties dt:dt="string">RADIUS_Server_Groups</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Proxy_Policies</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Proxy_Profiles</RequiredProperties>
# 							</Properties>
# 						</IAS_SDO>
# 						<TEMPLATES_SDO name="TEMPLATES_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoTemplatesRoot</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Description</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Policies_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Profiles_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Profiles_InPolicyTemplates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">ProxyPolicies_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">ProxyProfiles_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">ProxyProfiles_InPolicyTemplates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Radius_Clients_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">RADIUS_Servers_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">RADIUS_Shared_Secrets_Templates</RequiredProperties>
# 								<RequiredProperties dt:dt="string">IP_Filters_Templates</RequiredProperties>
# 							</Properties>
# 						</TEMPLATES_SDO>
# 						<RADIUS_SDO name="RADIUS_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.RadiusProtocol</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Vendor_Information</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Clients</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Authentication_Port</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Accounting_Port</RequiredProperties>
# 							</Properties>
# 						</RADIUS_SDO>
# 						<Protocol_Surrogate_SDO name="Protocol_Surrogate_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.IasHelper</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 							</Properties>
# 						</Protocol_Surrogate_SDO>
# 						<Vendor_Information_SDO name="Vendor_Information_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoVendor</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">NAS_Vendor_Id</RequiredProperties>
# 							</Properties>
# 						</Vendor_Information_SDO>
# 						<RADIUS_Server_Group_SDO name="RADIUS_Server_Group_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoRadiusServerGroup</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Servers</RequiredProperties>
# 							</Properties>
# 						</RADIUS_Server_Group_SDO>
# 						<RADIUS_Server_SDO name="RADIUS_Server_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoRadiusServer</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Server_Accounting_Port</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Server_Authentication_Port</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Accounting_Secret</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Authentication_Secret</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Address</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Forward_Accounting_On_Off</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Priority</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Weight</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Timeout</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Maximum_Lost_Packets</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Blackout_Interval</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Send_Signature</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Auth_Secret_Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Acct_Secret_Template_Guid</OptionalProperties>
# 							</Properties>
# 						</RADIUS_Server_SDO>
# 						<Microsoft_Proxy_Policy_Evaluator_SDO name="Microsoft_Proxy_Policy_Evaluator_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.ProxyPolicyEnforcer</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">NAP_Policies</RequiredProperties>
# 							</Properties>
# 						</Microsoft_Proxy_Policy_Evaluator_SDO>
# 						<Microsoft_RADIUS_Proxy_SDO name="Microsoft_RADIUS_Proxy_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.RadiusProxy</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Server_Groups</RequiredProperties>
# 							</Properties>
# 						</Microsoft_RADIUS_Proxy_SDO>
# 						<Microsoft_Database_Accounting_SDO name="Microsoft_Database_Accounting_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.DatabaseAccounting</ClassId>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Component_Prog_Id</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Accounting_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Interim_Accounting_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">Log_Authentication_Packets</RequiredProperties>
# 								<RequiredProperties dt:dt="string">SQL_Max_Sessions</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Log_Interim_Authentication_Packets</OptionalProperties>
# 								<RequiredProperties dt:dt="string">Discard_On_Failure</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 								<OptionalProperties dt:dt="string">Opaque_Data</OptionalProperties>
# 							</Properties>
# 						</Microsoft_Database_Accounting_SDO>
# 						<IP_Filter_SDO name="IP_Filter_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoIPFilter</ClassId>
# 								<RequiredProperties dt:dt="string">IP_Filter_Attributes</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 							</Properties>
# 						</IP_Filter_SDO>
# 						<Shared_Secret_SDO name="Shared_Secret_SDO">
# 							<Properties>
# 								<ClassId dt:dt="string">IAS.SdoSharedSecret</ClassId>
# 								<RequiredProperties dt:dt="string">RADIUS_Shared_Secret</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557888-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<RequiredProperties dt:dt="string">{46557889-4DB8-11d2-8ECE-00C04FC2F519}</RequiredProperties>
# 								<OptionalProperties dt:dt="string">Template_Guid</OptionalProperties>
# 							</Properties>
# 						</Shared_Secret_SDO>
# 					</Children>
# 				</SDO_Schema_Classes>
# 				<SDO_Schema_Properties name="SDO_Schema_Properties">
# 					<Children>
# 						<Description name="Description">
# 							<Properties>
# 								<Alias dt:dt="int">3</Alias>
# 								<Flags dt:dt="int">96</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MaxLength dt:dt="int">255</MaxLength>
# 							</Properties>
# 						</Description>
# 						<Template_Guid name="Template_Guid">
# 							<Properties>
# 								<Alias dt:dt="int">6</Alias>
# 								<Flags dt:dt="int">3120</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">38</MinLength>
# 								<MaxLength dt:dt="int">38</MaxLength>
# 								<DefaultValue dt:dt="string">{00000000-0000-0000-0000-000000000000}</DefaultValue>
# 							</Properties>
# 						</Template_Guid>
# 						<Opaque_Data name="Opaque_Data">
# 							<Properties>
# 								<Alias dt:dt="int">7</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<DefaultValue dt:dt="string"></DefaultValue>
# 							</Properties>
# 						</Opaque_Data>
# 						<Policies name="Policies">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Policies>
# 						<Profiles name="Profiles">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Profiles>
# 						<Protocols name="Protocols">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Protocols>
# 						<Auditors name="Auditors">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Auditors>
# 						<Request_Handlers name="Request_Handlers">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Request_Handlers>
# 						<Require_Signature name="Require_Signature">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Require_Signature>
# 						<Shared_Secret name="Shared_Secret">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">112</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">0</MinLength>
# 								<MaxLength dt:dt="int">64</MaxLength>
# 							</Properties>
# 						</Shared_Secret>
# 						<NAS_Manufacturer name="NAS_Manufacturer">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">0</DefaultValue>
# 							</Properties>
# 						</NAS_Manufacturer>
# 						<IP_Address name="IP_Address">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">64</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</IP_Address>
# 						<Condition_Text name="Condition_Text">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">64</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</Condition_Text>
# 						<Accounting_Port name="Accounting_Port">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<DefaultValue dt:dt="string">1813,1646</DefaultValue>
# 							</Properties>
# 						</Accounting_Port>
# 						<Authentication_Port name="Authentication_Port">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<DefaultValue dt:dt="string">1812,1645</DefaultValue>
# 							</Properties>
# 						</Authentication_Port>
# 						<Clients name="Clients">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">2498</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Clients>
# 						<Log_Application_Events name="Log_Application_Events">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Log_Application_Events>
# 						<Log_Malformed_Packets name="Log_Malformed_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Malformed_Packets>
# 						<Log_Verbose name="Log_Verbose">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Verbose>
# 						<Allow_LM_Authentication name="Allow_LM_Authentication">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Allow_LM_Authentication>
# 						<Log_Accounting_Packets name="Log_Accounting_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Accounting_Packets>
# 						<Log_Interim_Accounting_Packets name="Log_Interim_Accounting_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Interim_Accounting_Packets>
# 						<Log_Authentication_Packets name="Log_Authentication_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Authentication_Packets>
# 						<New_Log_Frequency name="New_Log_Frequency">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">3148</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">0</DefaultValue>
# 								<MinValue dt:dt="int">0</MinValue>
# 								<MaxValue dt:dt="int">5</MaxValue>
# 							</Properties>
# 						</New_Log_Frequency>
# 						<New_Log_Size name="New_Log_Size">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">3148</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">10</DefaultValue>
# 								<MinValue dt:dt="int">1</MinValue>
# 								<MaxValue dt:dt="int">100000</MaxValue>
# 							</Properties>
# 						</New_Log_Size>
# 						<Log_File_Directory name="Log_File_Directory">
# 							<Properties>
# 								<Alias dt:dt="int">1031</Alias>
# 								<Flags dt:dt="int">3184</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">1</MinLength>
# 								<MaxLength dt:dt="int">255</MaxLength>
# 								<DefaultValue dt:dt="string">%windir%\LogFiles</DefaultValue>
# 							</Properties>
# 						</Log_File_Directory>
# 						<Log_Format name="Log_Format">
# 							<Properties>
# 								<Alias dt:dt="int">1032</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">0</DefaultValue>
# 							</Properties>
# 						</Log_Format>
# 						<Component_Id name="Component_Id">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">64</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 							</Properties>
# 						</Component_Id>
# 						<Component_Prog_Id name="Component_Prog_Id">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">64</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</Component_Prog_Id>
# 						<Dictionary_Location name="Dictionary_Location">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">448</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</Dictionary_Location>
# 						<NAP_Policies name="NAP_Policies">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">2242</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</NAP_Policies>
# 						<msNPConstraint name="msNPConstraint">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">576</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</msNPConstraint>
# 						<msNPSequence name="msNPSequence">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">64</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 							</Properties>
# 						</msNPSequence>
# 						<msNPAction name="msNPAction">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">112</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">1</MinLength>
# 								<MaxLength dt:dt="int">255</MaxLength>
# 							</Properties>
# 						</msNPAction>
# 						<Policy_Action name="Policy_Action">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">193</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Policy_Action>
# 						<Conditions name="Conditions">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Conditions>
# 						<Profile_Attributes name="Profile_Attributes">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Profile_Attributes>
# 						<Attribute_Value name="Attribute_Value">
# 							<Properties>
# 								<Alias dt:dt="int">1036</Alias>
# 								<Flags dt:dt="int">192</Flags>
# 								<Syntax dt:dt="int">0</Syntax>
# 							</Properties>
# 						</Attribute_Value>
# 						<NAS_Vendor_Id name="NAS_Vendor_Id">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">320</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 							</Properties>
# 						</NAS_Vendor_Id>
# 						<Vendor_Information name="Vendor_Information">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Vendor_Information>
# 						<Proxy_Policies name="Proxy_Policies">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Proxy_Policies>
# 						<Proxy_Profiles name="Proxy_Profiles">
# 							<Properties>
# 								<Alias dt:dt="int">1031</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Proxy_Profiles>
# 						<RADIUS_Server_Groups name="RADIUS_Server_Groups">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</RADIUS_Server_Groups>
# 						<Servers name="Servers">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Servers>
# 						<Server_Accounting_Port name="Server_Accounting_Port">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">1813</DefaultValue>
# 							</Properties>
# 						</Server_Accounting_Port>
# 						<Accounting_Secret name="Accounting_Secret">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">0</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</Accounting_Secret>
# 						<Server_Authentication_Port name="Server_Authentication_Port">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">1812</DefaultValue>
# 							</Properties>
# 						</Server_Authentication_Port>
# 						<Authentication_Secret name="Authentication_Secret">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<DefaultValue dt:dt="string"></DefaultValue>
# 							</Properties>
# 						</Authentication_Secret>
# 						<Address name="Address">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">0</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 							</Properties>
# 						</Address>
# 						<Forward_Accounting_On_Off name="Forward_Accounting_On_Off">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Forward_Accounting_On_Off>
# 						<Priority name="Priority">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">1</DefaultValue>
# 							</Properties>
# 						</Priority>
# 						<Weight name="Weight">
# 							<Properties>
# 								<Alias dt:dt="int">1031</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">50</DefaultValue>
# 							</Properties>
# 						</Weight>
# 						<Server_Groups name="Server_Groups">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">2242</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Server_Groups>
# 						<Timeout name="Timeout">
# 							<Properties>
# 								<Alias dt:dt="int">1032</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">3</DefaultValue>
# 							</Properties>
# 						</Timeout>
# 						<Maximum_Lost_Packets name="Maximum_Lost_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1033</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">5</DefaultValue>
# 							</Properties>
# 						</Maximum_Lost_Packets>
# 						<Blackout_Interval name="Blackout_Interval">
# 							<Properties>
# 								<Alias dt:dt="int">1034</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">30</DefaultValue>
# 							</Properties>
# 						</Blackout_Interval>
# 						<Delete_If_Full name="Delete_If_Full">
# 							<Properties>
# 								<Alias dt:dt="int">1034</Alias>
# 								<Flags dt:dt="int">3072</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Delete_If_Full>
# 						<SQL_Max_Sessions name="SQL_Max_Sessions">
# 							<Properties>
# 								<Alias dt:dt="int">1035</Alias>
# 								<Flags dt:dt="int">2060</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<MinValue dt:dt="int">1</MinValue>
# 								<MaxValue dt:dt="int">100</MaxValue>
# 							</Properties>
# 						</SQL_Max_Sessions>
# 						<Log_Interim_Authentication_Packets name="Log_Interim_Authentication_Packets">
# 							<Properties>
# 								<Alias dt:dt="int">1036</Alias>
# 								<Flags dt:dt="int">3072</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_Interim_Authentication_Packets>
# 						<Policy_Enabled name="Policy_Enabled">
# 							<Properties>
# 								<Alias dt:dt="int">1031</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Policy_Enabled>
# 						<Radius_Client_Enabled name="Radius_Client_Enabled">
# 							<Properties>
# 								<Alias dt:dt="int">1030</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Radius_Client_Enabled>
# 						<Send_Signature name="Send_Signature">
# 							<Properties>
# 								<Alias dt:dt="int">1035</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Send_Signature>
# 						<Policy_SourceTag name="Policy_SourceTag">
# 							<Properties>
# 								<Alias dt:dt="int">1032</Alias>
# 								<Flags dt:dt="int">1088</Flags>
# 								<Syntax dt:dt="int">3</Syntax>
# 								<DefaultValue dt:dt="int">0</DefaultValue>
# 							</Properties>
# 						</Policy_SourceTag>
# 						<Log_File_Is_Backup name="Log_File_Is_Backup">
# 							<Properties>
# 								<Alias dt:dt="int">1037</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">0</DefaultValue>
# 							</Properties>
# 						</Log_File_Is_Backup>
# 						<Discard_On_Failure name="Discard_On_Failure">
# 							<Properties>
# 								<Alias dt:dt="int">1038</Alias>
# 								<Flags dt:dt="int">3136</Flags>
# 								<Syntax dt:dt="int">11</Syntax>
# 								<DefaultValue dt:dt="boolean">1</DefaultValue>
# 							</Properties>
# 						</Discard_On_Failure>
# 						<Policies_Templates name="Policies_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Policies_Templates>
# 						<Profiles_Templates name="Profiles_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Profiles_Templates>
# 						<Profiles_InPolicyTemplates name="Profiles_InPolicyTemplates">
# 							<Properties>
# 								<Alias dt:dt="int">1026</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Profiles_InPolicyTemplates>
# 						<ProxyPolicies_Templates name="ProxyPolicies_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1027</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</ProxyPolicies_Templates>
# 						<ProxyProfiles_Templates name="ProxyProfiles_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1028</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</ProxyProfiles_Templates>
# 						<ProxyProfiles_InPolicyTemplates name="ProxyProfiles_InPolicyTemplates">
# 							<Properties>
# 								<Alias dt:dt="int">1029</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</ProxyProfiles_InPolicyTemplates>
# 						<Radius_Clients_Templates name="Radius_Clients_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1032</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</Radius_Clients_Templates>
# 						<RADIUS_Servers_Templates name="RADIUS_Servers_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1033</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</RADIUS_Servers_Templates>
# 						<IP_Filter_Attributes name="IP_Filter_Attributes">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</IP_Filter_Attributes>
# 						<RADIUS_Shared_Secret name="RADIUS_Shared_Secret">
# 							<Properties>
# 								<Alias dt:dt="int">1024</Alias>
# 								<Flags dt:dt="int">1024</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<DefaultValue dt:dt="string"></DefaultValue>
# 							</Properties>
# 						</RADIUS_Shared_Secret>
# 						<RADIUS_Shared_Secrets_Templates name="RADIUS_Shared_Secrets_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1034</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</RADIUS_Shared_Secrets_Templates>
# 						<IP_Filters_Templates name="IP_Filters_Templates">
# 							<Properties>
# 								<Alias dt:dt="int">1035</Alias>
# 								<Flags dt:dt="int">450</Flags>
# 								<Syntax dt:dt="int">9</Syntax>
# 							</Properties>
# 						</IP_Filters_Templates>
# 						<IP_Filter_Template_Guid name="IP_Filter_Template_Guid">
# 							<Properties>
# 								<Alias dt:dt="int">1025</Alias>
# 								<Flags dt:dt="int">3120</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">38</MinLength>
# 								<MaxLength dt:dt="int">38</MaxLength>
# 								<DefaultValue dt:dt="string">{00000000-0000-0000-0000-000000000000}</DefaultValue>
# 							</Properties>
# 						</IP_Filter_Template_Guid>
# 						<Auth_Secret_Template_Guid name="Auth_Secret_Template_Guid">
# 							<Properties>
# 								<Alias dt:dt="int">1036</Alias>
# 								<Flags dt:dt="int">3120</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">38</MinLength>
# 								<MaxLength dt:dt="int">38</MaxLength>
# 								<DefaultValue dt:dt="string">{00000000-0000-0000-0000-000000000000}</DefaultValue>
# 							</Properties>
# 						</Auth_Secret_Template_Guid>
# 						<Acct_Secret_Template_Guid name="Acct_Secret_Template_Guid">
# 							<Properties>
# 								<Alias dt:dt="int">1037</Alias>
# 								<Flags dt:dt="int">3120</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">38</MinLength>
# 								<MaxLength dt:dt="int">38</MaxLength>
# 								<DefaultValue dt:dt="string">{00000000-0000-0000-0000-000000000000}</DefaultValue>
# 							</Properties>
# 						</Acct_Secret_Template_Guid>
# 						<Client_Secret_Template_Guid name="Client_Secret_Template_Guid">
# 							<Properties>
# 								<Alias dt:dt="int">1031</Alias>
# 								<Flags dt:dt="int">3120</Flags>
# 								<Syntax dt:dt="int">8</Syntax>
# 								<MinLength dt:dt="int">38</MinLength>
# 								<MaxLength dt:dt="int">38</MaxLength>
# 								<DefaultValue dt:dt="string">{00000000-0000-0000-0000-000000000000}</DefaultValue>
# 							</Properties>
# 						</Client_Secret_Template_Guid>
# 					</Children>
# 				</SDO_Schema_Properties>
# 			</Children>
# 		</SDO_Schema>
# 	</Children>
# 	<registryKeys>
# 		<registryKey keyName="SYSTEM\CurrentControlSet\Services\IAS\Parameters">
# 			<registryValue name="Allow SNMP Set" valueType="REG_DWORD" value="0"/>
# 		</registryKey>
# 		<registryKey keyName="SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\AccountLockout">
# 			<registryValue name="MaxDenials" valueType="REG_DWORD" value="0"/>
# 		</registryKey>
# 		<registryKey keyName="SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\AccountLockout">
# 			<registryValue name="ResetTime (mins)" valueType="REG_DWORD" value="2880"/>
# 		</registryKey>
# 		<registryKey keyName="SYSTEM\CurrentControlSet\Services\RemoteAccess\Policy">
# 			<registryValue name="Allow LM Authentication" valueType="REG_DWORD" value="0"/>
# 		</registryKey>
# 	</registryKeys>
# 	<SystemInfo ProcessorArchitecture="9" ProcessorLevel="6" ProcessorRevision="24067"/>
# </Root>
# '
# Import-NpsConfiguration -Path "$NPSTemplatePath"
# Write-Host "Standard NPS Policies have been created. You will need to add RADIUS Clients. Add Radius Clients now? y/n"
# $AddRadiusClientChoice=Read-Host
# do {
# if ($AddRadiusClientChoice -eq "n") {}
# 	else {
# 	Write-Host "Enter IP of Radius Client"
# 	$NPSRadiusUserInputIP=Read-Host
# 	Write-Host "Enter Name For Radius Host"
# 	$NPSRadiusUserInputName=Read-Host
# 	$NPSDefaultSharedSecret="Welcome1"
# 	Write-Host "Accept Default Shared Secret? "Welcome1" y/n"
# 	$NPSUserInputSharedSecretChoice=Read-Host
# 	if ($NPSUserInputSharedSecretChoice -eq "y") {
# 		New-NpsRadiusClient -Address $NPSRadiusUserInputIP -Name "$NPSRadiusUserInputName" -SharedSecret "$NPSDefaultSharedSecret"
# 	}
# 		else {
# 			Write-Host "Enter Shared Secret"
# 			$NPSUserInputSharedSecret=Read-Host
# 			New-NpsRadiusClient -Address $NPSRadiusUserInputIP -Name "$NPSRadiusUserInputName" -SharedSecret "$NPSUserInputSharedSecret"
# 		}
#         Write-Host "Add Another Radius Client? y/n"
#         $AddRadiusClientChoice=Read-Host}
 
#     } until ($AddRadiusClientChoice -eq "n") 
# Write-Host "Registry Keys and Standard NPS Policies have been created.  You will need to add the User Group to the 'Contrants' part of the policy for the appropriate Policy. If you didn't add RADIUS Clients you will also have to add those manually."
# }
# else {Write-Host "NPAS Role Already Installed - No Action Needed"}