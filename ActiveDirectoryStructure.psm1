
$DEFAULTSUFFIXNAME = 'local'

#Checking if the EpiOn and Managed LAN OU's exist
function Get-ADStructure {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    $domainPrefixName = (Get-ADDomain).name

    #EpiOn OU
    if  ([adsi]::Exists("LDAP://OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and 
    #Managed LAN OU
        ([adsi]::Exists("LDAP://OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and

    #Desktop OU
        ([adsi]::Exists("LDAP://OU=Desktops,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and

    #Phone OU
        ([adsi]::Exists("LDAP://OU=Phones,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and

    #Printer OU
        ([adsi]::Exists("LDAP://OU=Printers,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and

    #Thin Client OU
        ([adsi]::Exists("LDAP://OU=Thin Clients,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName") -and

    #Misc OU
        ([adsi]::Exists("LDAP://OU=Misc,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")
    ))))))) {
        return $true
    } else {
        return $false
    }
}

#Creates AD Structure. Typically used when Get-ADStructure is False.
function Create-ADStructure {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
    )

    Import-Module ActiveDirectory
    $domainPrefixName = (Get-ADDomain).name

    #EpiOn OU
    if ([adsi]::Exists("LDAP://OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'EpiOn OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create EpiOn OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'EpiOn' -Path "DC=$domainPrefixName,DC=$domainSuffixName" 
            if ([adsi]::Exists("LDAP://OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the EpiOn OU" -ForegroundColor Green
            }   
        }
        catch {
            {Write-Host "Can't Create EpiOn OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Managed LAN OU
    if ([adsi]::Exists("LDAP://OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Managed LAN OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Managed LAN OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Managed LAN' -Path "OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Managed LAN OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Managed LAN OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Desktop OU
    if ([adsi]::Exists("LDAP://OU=Desktops,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Desktops OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Desktops OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Desktops' -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Desktops,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Desktops OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Desktop OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Phone OU
    if ([adsi]::Exists("LDAP://OU=Phones,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Phones OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Phones OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Phones' -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Phones,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Phones OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Phone OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Printer OU
    if ([adsi]::Exists("LDAP://OU=Printers,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Printers OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Printers OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Printers' -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Printers,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Printers OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Printers OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Thin Client OU
    if ([adsi]::Exists("LDAP://OU=Thin Clients,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Thin Clients OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Thin Clients OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Thin Clients' -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Thin Clients,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Thin Clients OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Thin Clients OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
    #Misc OU
    if ([adsi]::Exists("LDAP://OU=Misc,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
        Write-Host 'Misc OU Exists' -ForegroundColor Green
    } else {
        Write-Host 'Attempting to Create Misc OU' -ForegroundColor Yellow
        try {
            New-ADOrganizationalUnit -Name 'Misc' -Path "OU=Managed LAN,OU=EpiOn,DC=$domainPrefixName,DC=$domainSuffixName"
            if ([adsi]::Exists("LDAP://OU=Misc,OU=Managed LAN,OU=epion,DC=$domainPrefixName,DC=$domainSuffixName")) {
                Write-Host "Successfully Created the Misc OU" -ForegroundColor Green
            } 
        }
        catch {
            {Write-Host "Can't Create Misc OU. Typically this indicates incorrect Domain Suffix. " -ForegroundColor Red}
        }
    }
}

#Used in the Managed LAN Groups Module to Obtain the OU Path
function Get-ADStructureName {
    param(
        [Parameter()]
        [string] $domainSuffixName = $DEFAULTSUFFIXNAME
        ,
        [Parameter(Mandatory)]
        [bool] $suffixOrPrefix
    )

    Import-Module ActiveDirectory
    $domainPrefixName = (Get-ADDomain).name
    if ($suffixOrPrefix) {
        return $domainPrefixName
    } else {
        return $domainSuffixName
    }
}