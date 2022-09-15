


function Import-ManagedLANDevices {
    param()

    #Device CSV's
    $DesktopUserAccounts = Import-CSV "C:\temp\Desktop.csv"
    $PhoneUserAccounts = Import-CSV "C:\temp\Phone.csv"
    $PrinterUserAccounts = Import-CSV "C:\temp\Printer.csv"
    $ThinClientUserAccounts = Import-CSV "C:\temp\ThinClient.csv"
    $MiscUserAccounts = Import-CSV "C:\temp\Misc.csv"

    #Used in the Device Creation Loop
    $allDeviceLists = @($DesktopUserAccounts, $PhoneUserAccounts, $PrinterUserAccounts, $ThinClientUserAccounts, $MiscUserAccounts)

    #OU Path for each device type
    $DesktopOUPath = "OU=Desktops,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $PhonesOUPath = "OU=Phones,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $PrintersOUPath = "OU=Printers,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $ThinClientsOUPath = "OU=Thin Clients,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $MiscOUPath = "OU=Misc,OU=Managed LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
    $OUPathList = @($DesktopOUPath, $PhonesOUPath, $PrintersOUPath, $ThinClientsOUPath, $MiscOUPath)

    #Default Group Assignments for each device type
    $DesktopGroup = Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
    $PhoneGroup = Get-ADGroup "Managed LAN VLAN 20 - Internet Only" -Properties @("PrimaryGroupToken")
    $PrinterGroup = Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
    $ThinClientGroup = Get-ADGroup "Managed LAN VLAN 1 - Secure" -Properties @("PrimaryGroupToken")
    $MiscGroup = Get-ADGroup "Managed LAN VLAN 20 - Internet Only" -Properties @("PrimaryGroupToken")
    $groups = @($DesktopGroup, $PhoneGroup, $PrinterGroup, $ThinClientGroup, $MiscGroup)

    #Variables for the device creation loop
    $DomainName = (Get-WmiObject Win32_ComputerSystem).Domain
    $DomainUPN = "@$DomainName"
    #Used to specifiy a specific server for creating accounts. Without this, the script might hit more than one DC and that
    #will generate errors.
    $DomainServer = (Get-ADDomain).PDCEmulator
    $listIncrement = 0
    $groupIncrement = 0
    $pathIncrement = 0
        foreach ($list in $allDeviceLists) {
            foreach ($device in $list[$listIncrement]) {
                if (Get-ADUser -Filter "sAMAccountName -eq '$device'") {
                    "Desktop User Account '$device' Exists Already"}
                else {
                Write-Host "Creating Desktop User '$device'"
                New-ADUser `
                    -Server $DomainServer `
                    -Name $device `
                    -Path "$OUPathList[$pathIncrement]" `
                    -UserPrincipalName "$device$DomainUPN" `
                    -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
                    -Enabled $true `
                    -PasswordNeverExpires $true `
                    -AllowReversiblePasswordEncryption $true 
                            
                Add-ADGroupMember `
                    -Server $DomainServer `
                    -identity "$groups[$groupIncrement]" `
                    -Members $device
    
                Get-ADUser `
                    -Server $DomainServer `
                    -identity $device | Set-ADUser `
                    -Server $DomainServer `
                    -Replace @{primarygroupid=$groups[$groupIncrement].primarygrouptoken}
    
                Remove-ADGroupMember `
                    -Server $DomainServer `
                    -identity "Domain Users" `
                    -Members "$device" `
                    -confirm:$false
    
                Set-ADAccountPassword `
                    -Server $DomainServer `
                    -Identity $device `
                    -NewPassword (ConvertTo-SecureString `
                        -AsPlainText $device `
                        -Force) `
                        -Reset `
            }
        }
        $listIncrement++
        $pathIncrement++
        $groupIncrement++
    }
}