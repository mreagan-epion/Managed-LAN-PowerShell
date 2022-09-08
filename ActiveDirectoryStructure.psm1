

function Get-ADStructure {
    param(
        [Parameter()]
        [string]
        $ParameterName = '.local'
    )

    Import-Module ActiveDirectory
    Write-Host (Get-ADDomain)$ParameterName

}