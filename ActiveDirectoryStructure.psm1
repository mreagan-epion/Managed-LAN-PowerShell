

function Get-ADStructure {
    param(
        #[Parameter(Mandatory=$False, Position=0)] [String] $DomainServer #Get-ADDomain
    )

    Import-Module ActiveDirectory
    Write-Host Get-ADDomain.Names

}