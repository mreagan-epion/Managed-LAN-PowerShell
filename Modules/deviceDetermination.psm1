


function Get-DeviceType {
    param (
        [Parameter(Mandatory)]
        [string] $macAddress
    )

    $commonDesktopBrands = @("Dell", "Dell Inc.", "Elitegro", "Micro-St", "Ce Link Limited", "AsustekC", "ASRock Incorporation", "Plugable Technologies", "Winstars Technology Ltd", "IEEE Registration Authority", "ASUSTek COMPUTER INC.")
    $commonPhoneBrands = @("Esi", "Zultys", "XiamenYe", "Xiamen Yealink Network Technology Co.,Ltd", "Sensapho", "")
    $commonPrinterBrands = @("KYOCERA Display Corporation", "HewlettP", "Hewlett Packard", "Lexmark International, Inc.", "KonicaMi", "Brother Industries, LTD.")
    $commonThinClientBrands = @("Raspberry Pi Foundation", "Raspberry Pi Trading Ltd")
    $placements = @($commonDesktopBrands, $commonPhoneBrands, $commonPrinterBrands, $commonThinClientBrands)
    

    switch ($macAddress) {
        {$commonDesktopBrands -contains $_} {return "Desktop"; break;}
        {$commonPhoneBrands -contains $_} {return "Phone"; break;}
        {$commonPrinterBrands -contains $_} {return "Printer"; break;}
        {$commonThinClientBrands -contains $_} {return "ThinClient"; break;}
        default {return "Misc";}
    }
}