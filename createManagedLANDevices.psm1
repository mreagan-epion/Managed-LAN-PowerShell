


$DEFAULTSUFFIXNAME = "local"
function Import-ManagedLANDevices {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    $domainPrefixName = (Get-ADDomain).name

    #Device CSV's
    $DesktopUserAccounts = Import-CSV "C:\temp\Desktop.csv"
    $PhoneUserAccounts = Import-CSV "C:\temp\Phone.csv"
    $PrinterUserAccounts = Import-CSV "C:\temp\Printer.csv"
    $ThinClientUserAccounts = Import-CSV "C:\temp\ThinClient.csv"
    $MiscUserAccounts = Import-CSV "C:\temp\Misc.csv"

    #Used in the Device Creation Loop
    $allDeviceLists = @($DesktopUserAccounts, $PhoneUserAccounts, $PrinterUserAccounts, $ThinClientUserAccounts, $MiscUserAccounts)

    #OU Path for each device type
    $DesktopOUPath = "OU=Desktops,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $PhonesOUPath = "OU=Phones,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $PrintersOUPath = "OU=Printers,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $ThinClientsOUPath = "OU=Thin_Clients,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $MiscOUPath = "OU=Misc,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $OUPathList = @($DesktopOUPath, $PhonesOUPath, $PrintersOUPath, $ThinClientsOUPath, $MiscOUPath)

    #Default Group Assignments for each device type
    $DesktopGroup = Get-ADGroup "Managed_LAN_VLAN_1_Secure" -Properties @("PrimaryGroupToken")
    $PhoneGroup = Get-ADGroup "Managed_LAN_VLAN_20_Internet_Only" -Properties @("PrimaryGroupToken")
    $PrinterGroup = Get-ADGroup "Managed_LAN_VLAN_1_Secure" -Properties @("PrimaryGroupToken")
    $ThinClientGroup = Get-ADGroup "Managed_LAN_VLAN_1_Secure" -Properties @("PrimaryGroupToken")
    $MiscGroup = Get-ADGroup "Managed_LAN_VLAN_20_Internet_Only" -Properties @("PrimaryGroupToken")
    $groups = @($DesktopGroup, $PhoneGroup, $PrinterGroup, $ThinClientGroup, $MiscGroup)

    #Variables for the device creation loop
    $DomainName = (Get-WmiObject Win32_ComputerSystem).Domain
    $DomainUPN = "@$DomainName"
    #Used to specifiy a specific server for creating accounts. Without this, the script might hit more than one DC and that
    #will generate errors.
    $DomainServer = (Get-ADDomain).PDCEmulator
    # $listIncrement = 0
    $groupIncrement = 0
    $pathIncrement = 0
    foreach ($list in $allDeviceLists) {
        foreach ($list in $allDeviceLists) {
            $list | ForEach-Object {
                if (Get-ADUser -Filter "sAMAccountName -eq '$($_.line)'") {
                    "Desktop User Account '$($_.line)' Already Exists"}
                else {
                Write-Host "Creating Desktop User '$($_.line)'"
                New-ADUser `
                    -Server $DomainServer `
                    -Name $($_.line) `
                    -Path $OUPathList[$pathIncrement] `
                    -UserPrincipalName "$($_.line)$DomainUPN" `
                    -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
                    -Enabled $true `
                    -PasswordNeverExpires $true `
                    -AllowReversiblePasswordEncryption $true 
                            
                Add-ADGroupMember `
                    -Server $DomainServer `
                    -identity $groups[$groupIncrement] `
                    -Members $($_.line)
        
                Get-ADUser `
                    -Server $DomainServer `
                    -identity $($_.line) | Set-ADUser `
                    -Server $DomainServer `
                    -Replace @{primarygroupid=$groups[$groupIncrement].primarygrouptoken}
        
                Remove-ADGroupMember `
                    -Server $DomainServer `
                    -identity "Domain Users" `
                    -Members "$($_.line)" `
                    -confirm:$false
        
                Set-ADAccountPassword `
                    -Server $DomainServer `
                    -Identity $($_.line) `
                    -NewPassword (ConvertTo-SecureString `
                        -AsPlainText $($_.line) `
                        -Force) `
                        -Reset `
                }
            # $listIncrement++
            $groupIncrement++
            $pathIncrement++
            }
        }
    }
}