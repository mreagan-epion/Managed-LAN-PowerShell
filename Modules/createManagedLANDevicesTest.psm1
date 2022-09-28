


$DEFAULTSUFFIXNAME = "local"
function Import-ManagedLANDevices {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    Import-Module .\Modules\createManagedLANDevicesTest.psm1
    Import-Module .\Modules\deviceDetermination.psm1
    $domainPrefixName = (Get-ADDomain).name

    #Device CSV
    $deviceList = Import-Csv -Path "C:\Temp\MACExport.csv"

    #Used in the Device Creation Loop
    # $allDeviceLists = @($DesktopUserAccounts, $PhoneUserAccounts, $PrinterUserAccounts, $ThinClientUserAccounts, $MiscUserAccounts)

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
    
    #Temp name for loop below
    New-Variable -Name "name"

    #Increment serves two points of reference; OU Path and Groups
    $increment = 0
    $deviceList | ForEach-Object {
        #Gets device type
        $deviceGroup = Get-DeviceType -macAddress "$($_.mac)"
        switch ($deviceGroup) {
            {$_ -eq "Desktop"} {Set-Variable $increment -Value 0; break;}
            {$_ -eq "Phone"} {Set-Variable $increment -Value 1; break;}
            {$_ -eq "Printer"} {Set-Variable $increment -Value 2; break;}
            {$_ -eq "ThinClient"} {Set-Variable $increment -Value 3; break;}
            Default {Set-Variable $increment -Value 4; break;}
        }
        #Checks if account exists
        if (Get-ADUser -Filter "sAMAccountName -eq '$($_.mac)'") {
            "User Account '$($_.mac)' '$($_.hostname)' Already Exists"}
        else {
            Write-Host "Creating User '$($_.mac)' '$($_.hostname)'"
            #Determining the display name of the account for quick ID
            if (!($($_.hostname))) {
                $name = "$($_.mac)"
            } else {
                $name = $($_.hostname)
            }
            New-ADUser `
                -Server $DomainServer `
                -Name $name `
                -Path $OUPathList[$increment] `
                -UserPrincipalName "$($_.mac)$DomainUPN" `
                -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
                -Enabled $true `
                -PasswordNeverExpires $true `
                -AllowReversiblePasswordEncryption $true 
                        
            Add-ADGroupMember `
                -Server $DomainServer `
                -identity $groups[$increment] `
                -Members $name

            Get-ADUser `
                -Server $DomainServer `
                -identity $name | Set-ADUser `
                -Server $DomainServer `
                -Replace @{primarygroupid=$groups[$increment].primarygrouptoken}

            Remove-ADGroupMember `
                -Server $DomainServer `
                -identity "Domain Users" `
                -Members "$name" `
                -confirm:$false

            Set-ADAccountPassword `
                -Server $DomainServer `
                -Identity $name `
                -NewPassword (ConvertTo-SecureString `
                    -AsPlainText $($_.mac) `
                    -Force) `
                    -Reset `
        }
    }
}

