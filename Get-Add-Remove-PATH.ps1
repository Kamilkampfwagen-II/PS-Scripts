function Get-PATH {
    param(
        [switch]$Machine
    )

    if ($Machine) {
        return [Environment]::GetEnvironmentVariable('PATH', 'Machine').Split(';')
    } else {
        return [Environment]::GetEnvironmentVariable('PATH', 'User').Split(';')
    }
}

function Add-PATH {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path,
        [switch]$Machine
    )

    if ($Machine -and !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        throw 'Administrator privilege required for this operation.'
    }

    $envPath = [System.Collections.ArrayList](Get-PATH -Machine:$Machine)
    $envPath.Add($Path) | Out-Null
    $envPath = $envPath -join ';'

    if ($Machine) {
        [Environment]::SetEnvironmentVariable('PATH', $envPath, 'Machine')
    } else {
        [Environment]::SetEnvironmentVariable('PATH', $envPath, 'User')
    }
}

function Remove-PATH {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path,
        [switch]$Machine
    )

    if ($Machine -and !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        throw 'Administrator privilege required for this operation.'
    }

    $envPath = [System.Collections.ArrayList](Get-PATH -Machine:$Machine)
    $envPath.Remove($Path) | Out-Null
    $envPath = $envPath -join ';'

    if ($Machine) {
        [Environment]::SetEnvironmentVariable('PATH', $envPath, 'Machine')
    } else {
        [Environment]::SetEnvironmentVariable('PATH', $envPath, 'User')
    }
}
