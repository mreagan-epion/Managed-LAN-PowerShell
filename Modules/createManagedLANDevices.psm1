


$DEFAULTSUFFIXNAME = "local"
function Import-ManagedLANDevices {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    Import-Module .\Modules\createManagedLANDevices.psm1
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
    $vlan1 = Get-ADGroup "Managed_LAN_VLAN_1_Secure" -Properties @("PrimaryGroupToken")
    $vlan20 = Get-ADGroup "Managed_LAN_VLAN_20_Internet_Only" -Properties @("PrimaryGroupToken")
    $groups = @($vlan1, $vlan20)

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
    $groupIncrement = 0
    $deviceList | ForEach-Object {
        #Gets device type. Checks if $hostname exists or not. If not, it's set to Misc. 
        $deviceGroup = Get-DeviceType -ouiAddress "$($_.oui)" -ErrorAction SilentlyContinue
        switch ($deviceGroup) {
            {$_ -eq "Desktop"} {$increment = 0; $groupIncrement = 0; break;}
            {$_ -eq "Phone"} {$increment = 1; $groupIncrement = 1; break;}
            {$_ -eq "Printer"} {$increment = 2; $groupIncrement = 0; break;}
            {$_ -eq "ThinClient"} {$increment = 3; $groupIncrement = 0; break;}
            Default {$increment = 4; $groupIncrement = 1; break;}
        }
        #Missing vendor info. Unsure where to place the device:
        if (!$($_.oui)) {
            $deviceGroupQuery = Read-Host "Vendor information is missing. The Device Name is $($_.hostname) and the Mac Address is $($_.mac). Enter 0 to put it in the Secure VLAN and 1 to put it into the Internet Only VLAN."
            if ($deviceGroupQuery -eq 0) {
                $deviceGroup = "Desktop"
                $increment = 0
                $groupIncrement = 0
            } elseif ($deviceGroupQuery -eq 1) {
                $deviceGroup = "Misc"
                $increment = 4
                $groupIncrement = 1
            }
        }
        #Checks if account exists
        if (Get-ADUser -Filter "sAMAccountName -eq '$($_.mac)'") {
            "User Account '$($_.mac)' '$($_.hostname)' Already Exists"
        }
        else {
            Write-Host "Creating User '$($_.mac)' '$($_.hostname)'"
            #Determining the display name of the account for quick ID
            if (!($($_.hostname))) {
                $name = "$($_.mac)-$($_.oui)"
            } else {
                #Creating unique user IDs
                $lastFour = $($_.mac).subString(12 -4)
                $name = "$($_.hostname)-$lastFour"
            }
            #Making sure the $name is less than 20 characters
            # $nameCheck = $name | Measure-Object -Character
            # if ($nameCheck.Characters -gt 20) {
            #     $name = $name.subString(0, [System.Math]::Min(20, $name.Length))
            # }
            New-ADUser `
                -Server $DomainServer `
                -Name $($_.mac) `
                -DisplayName $name `
                -Path $OUPathList[$increment] `
                -UserPrincipalName "$($_.mac)$DomainUPN" `
                -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
                -Enabled $true `
                -PasswordNeverExpires $true `
                -AllowReversiblePasswordEncryption $true `
                -Description "This device was automatically created by the EpiOn Managed LAN Script. It was originally placed in the $deviceGroup OU. If present, the vendor ID is $($_.oui)"
                        
            Add-ADGroupMember `
                -Server $DomainServer `
                -identity $groups[$groupIncrement] `
                -Members $($_.mac)

            Get-ADUser `
                -Server $DomainServer `
                -identity $($_.mac) | Set-ADUser `
                -Server $DomainServer `
                -Replace @{primarygroupid=$groups[$groupIncrement].primarygrouptoken}

            Remove-ADGroupMember `
                -Server $DomainServer `
                -identity "Domain Users" `
                -Members "$($_.mac)" `
                -confirm:$false

            Set-ADAccountPassword `
                -Server $DomainServer `
                -Identity $($_.mac) `
                -NewPassword (ConvertTo-SecureString `
                    -AsPlainText $($_.mac) `
                    -Force) `
                    -Reset `
        }
    }
}

function Create-ManagedLANDevice { #Single User Creation
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    Import-Module .\Modules\createManagedLANDevices.psm1
    Import-Module .\Modules\deviceDetermination.psm1
    $domainPrefixName = (Get-ADDomain).name
    #Temp name for loop below
    New-Variable -Name "name"
    $answer = "Y"
    do {
        #Device Input
        Clear-Host
        Write-Host "You will be prompted to enter the MAC Address, please make sure to remove colons and Upper Case all letters." -ForegroundColor Yellow
        $deviceMac = Read-Host "Please enter the MAC Address: "
        $deviceHostname = Read-Host "Please enter the Hostname (Can be blank): "
        # $deviceOUI = Read-Host "Please enter the Vendor Type (Can be blank): "

        #OU Path for each device type
        $DesktopOUPath = "OU=Desktops,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
        $PhonesOUPath = "OU=Phones,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
        $PrintersOUPath = "OU=Printers,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
        $ThinClientsOUPath = "OU=Thin_Clients,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
        $MiscOUPath = "OU=Misc,OU=Managed_LAN,OU=EpiOn,DC=$DomainPrefixName,DC=$DomainSuffixName"
        $OUPathList = @($DesktopOUPath, $PhonesOUPath, $PrintersOUPath, $ThinClientsOUPath, $MiscOUPath)

        #Default Group Assignments for each device type
        $vlan1 = Get-ADGroup "Managed_LAN_VLAN_1_Secure" -Properties @("PrimaryGroupToken")
        $vlan20 = Get-ADGroup "Managed_LAN_VLAN_20_Internet_Only" -Properties @("PrimaryGroupToken")
        $groups = @($vlan1, $vlan20)

        #Variables for the device creation loop
        $DomainName = (Get-WmiObject Win32_ComputerSystem).Domain
        $DomainUPN = "@$DomainName"
        #Used to specifiy a specific server for creating accounts. Without this, the script might hit more than one DC and that
        #will generate errors.
        $DomainServer = (Get-ADDomain).PDCEmulator

        #Increment serves two points of reference; OU Path and Groups
        $increment = 0
        $groupIncrement = 0
        #Gets device type. Checks if $hostname exists or not. If not, it's set to Misc. 
        $deviceGroup = Get-DeviceType -ouiAddress $deviceOUI -ErrorAction SilentlyContinue
        switch ($deviceGroup) {
            {$_ -eq "Desktop"} {$increment = 0; $groupIncrement = 0; break;}
            {$_ -eq "Phone"} {$increment = 1; $groupIncrement = 1; break;}
            {$_ -eq "Printer"} {$increment = 2; $groupIncrement = 0; break;}
            {$_ -eq "ThinClient"} {$increment = 3; $groupIncrement = 0; break;}
            Default {$increment = 4; $groupIncrement = 1; break;}
        }
        #Missing vendor info. Unsure where to place the device:
        if (!$deviceOUI) {
            $deviceGroupQuery = Read-Host "Enter 0 to put it in the Secure VLAN and 1 to put it into the Internet Only VLAN."
            if ($deviceGroupQuery -eq 0) {
                $deviceGroup = "Desktop"
                $increment = 0
                $groupIncrement = 0
            } elseif ($deviceGroupQuery -eq 1) {
                $deviceGroup = "Misc"
                $increment = 4
                $groupIncrement = 1
            }
        }
        #Checks if account exists
        if (Get-ADUser -Filter "sAMAccountName -eq '$deviceMac'") {
            Write-Host "User Account $deviceMac $deviceHostname Already Exists"
        }
        else {
            Write-Host "Creating User $deviceMac $deviceHostname"
            #Determining the display name of the account for quick ID
            if (!$deviceHostname) {
                $name = "$deviceMac-$deviceOUI"
            } else {
                #Creating unique user IDs
                $lastFour = $deviceMac.subString(12 -4)
                $name = "$deviceHostname-$lastFour"
            }
            #Making sure the $name is less than 20 characters
            # $nameCheck = $name | Measure-Object -Character
            # if ($nameCheck.Characters -gt 20) {
            #     $name = $name.subString(0, [System.Math]::Min(20, $name.Length))
            # }
            New-ADUser `
                -Server $DomainServer `
                -Name $deviceMac `
                -DisplayName $name `
                -Path $OUPathList[$increment] `
                -UserPrincipalName "$deviceMac$DomainUPN" `
                -AccountPassword (convertto-securestring "%Ehy7QX#l@CWo$A*5IkO" -AsPlainText -Force) `
                -Enabled $true `
                -PasswordNeverExpires $true `
                -AllowReversiblePasswordEncryption $true `
                -Description "This device was automatically created by the EpiOn Managed LAN Script. It was originally placed in the $deviceGroup OU. If present, the vendor ID is $deviceOUI"
                        
            Add-ADGroupMember `
                -Server $DomainServer `
                -identity $groups[$groupIncrement] `
                -Members $deviceMac

            Get-ADUser `
                -Server $DomainServer `
                -identity $deviceMac | Set-ADUser `
                -Server $DomainServer `
                -Replace @{primarygroupid=$groups[$groupIncrement].primarygrouptoken}

            Remove-ADGroupMember `
                -Server $DomainServer `
                -identity "Domain Users" `
                -Members $deviceMac `
                -confirm:$false

            Set-ADAccountPassword `
                -Server $DomainServer `
                -Identity $deviceMac `
                -NewPassword (ConvertTo-SecureString `
                    -AsPlainText $deviceMac `
                    -Force) `
                    -Reset `
        }
        $answer = Read-Host "Add another device? y/n"
    } while (($answer -eq "Y") -or ($answer -eq "y"))
}
