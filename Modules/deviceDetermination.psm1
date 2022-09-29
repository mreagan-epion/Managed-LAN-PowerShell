


function Get-DeviceType {
    param (
        [Parameter()]
        [string] $macAddress
    )

    $commonDesktopBrands = @("Dell", "DellInc", "Elitegro", "Micro-St", "CeLinkLimited", "AsustekC", "ASRockIncorporation", "PlugableTechnologies", "WinstarsTechnologyLtd", "IEEERegistrationAuthority", "ASUSTekCOMPUTERINC", "VMwareInc", "HewlettPackardEnterprise")
    $commonPhoneBrands = @("Esi", "Zultys", "XiamenYe", "XiamenYealinkNetworkTechnologyCoLtd", "Sensapho")
    $commonPrinterBrands = @("KYOCERADisplayCorporation", "HewlettP", "HewlettPackard", "LexmarkInternationalInc", "KonicaMi", "BrotherIndustriesLTD", "Ricoh", "ZebraTechnologiesCorpa", "CanonInc", "ZebraTec", "NortelNetworks")
    $commonThinClientBrands = @("RaspberryPiFoundation", "RaspberryPiTradingLtd")
    
    $vlan1 = 0
    $vlan20 = 1

    switch ($macAddress) {
        {$commonDesktopBrands -contains $_} {return @("Desktop", $vlan1); break;}
        {$commonPhoneBrands -contains $_} {return @("Phone", $vlan20); break;}
        {$commonPrinterBrands -contains $_} {return @("Printer", $vlan1); break;}
        {$commonThinClientBrands -contains $_} {return @("ThinClient", $vlan1); break;}
        default {return @("Misc", $vlan20);}
    }
}