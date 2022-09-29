


function Get-DeviceType {
    param (
        [Parameter()]
        [string] $macAddress
    )

    $commonDesktopBrands = @("Dell", "DellInc", "Elitegro", "Micro-St", "CeLinkLimited", "AsustekC", "ASRockIncorporation", "PlugableTechnologies", "WinstarsTechnologyLtd", "IEEERegistrationAuthority", "ASUSTekCOMPUTERINC")
    $commonPhoneBrands = @("Esi", "Zultys", "XiamenYe", "XiamenYealinkNetworkTechnologyCoLtd", "Sensapho")
    $commonPrinterBrands = @("KYOCERADisplayCorporation", "HewlettP", "HewlettPackard", "LexmarkInternationalInc", "KonicaMi", "BrotherIndustriesLTD")
    $commonThinClientBrands = @("RaspberryPiFoundation", "RaspberryPiTradingLtd")
    

    switch ($macAddress) {
        {$commonDesktopBrands -contains $_} {return "Desktop"; break;}
        {$commonPhoneBrands -contains $_} {return "Phone"; break;}
        {$commonPrinterBrands -contains $_} {return "Printer"; break;}
        {$commonThinClientBrands -contains $_} {return "ThinClient"; break;}
        default {return "Misc";}
    }
}