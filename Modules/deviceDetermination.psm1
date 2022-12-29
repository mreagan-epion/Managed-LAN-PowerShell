


function Get-DeviceType {
    param (
        [Parameter()]
        [string] $ouiAddress
    )

    $commonDesktopBrands = @("Dell", "DellInc", "Elitegro", "MicroSt", "CeLinkLimited", "AsustekC", "ASRockIncorporation", "PlugableTechnologies", "WinstarsTechnologyLtd", "IEEERegistrationAuthority", "ASUSTekCOMPUTERINC", "BroadcomLimited")
    $commonPhoneBrands = @("Esi", "Zultys", "XiamenYe", "XiamenYealinkNetworkTechnologyCoLtd", "Sensapho", "Polycom")
    $commonPrinterBrands = @("KYOCERADisplayCorporation", "HewlettP", "HewlettPackard", "LexmarkInternationalInc", "KonicaMi", "BrotherIndustriesLTD", "CanonInc")
    $commonThinClientBrands = @("RaspberryPiFoundation", "RaspberryPiTradingLtd")
    

    switch ($ouiAddress) {
        {$commonDesktopBrands -contains $_} {return "Desktop"; break;}
        {$commonPhoneBrands -contains $_} {return "Phone"; break;}
        {$commonPrinterBrands -contains $_} {return "Printer"; break;}
        {$commonThinClientBrands -contains $_} {return "ThinClient"; break;}
        default {return "Misc";}
    }
}