


# Import-Module .\connectToUniFiController.psm1

# Export-Devices -URI 10.1.5.16

function test {
    param (
        # OptionalParameters
    )
    $var = @"Hello World"

    return $var
}

function test2 {
    param (
        # OptionalParameters
    )
    $var2 = test

    Write-Host $var2
    
}

test2