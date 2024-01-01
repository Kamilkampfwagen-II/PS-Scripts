#requires -PSEdition Desktop

# This is a proxy function for Invoke-WebRequest that ensures compatibility when Internet Explorer is not present.
function Invoke-WebRequest {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Uri,
        [switch]$UseBasicParsing,
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,
        [string]$SessionVariable,
        [pscredential]$Credential,
        [switch]$UseDefaultCredentials,
        [string]$CertificateThumbprint,
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Certificate,
        [string]$UserAgent,
        [switch]$DisableKeepAlive,
        [int]$TimeoutSec,
        [System.Collections.IDictionary]$Headers,
        [int]$MaximumRedirection,
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method,
        [uri]$Proxy,
        [pscredential]$ProxyCredential,
        [switch]$ProxyUseDefaultCredentials,
        [Object]$Body,
        [string]$ContentType,
        [string]$TransferEncoding,
        [string]$InFile,
        [string]$OutFile,
        [switch]$PassThru
    )

    $params = @{}
    # Iterate over all parameters
    foreach ($param in (Get-Command -Name $MyInvocation.MyCommand.Name).Parameters.Keys) {
        # If the parameter is not null, add it to the $params hashtable
        if ($null -ne $PSBoundParameters[$param]) {
            $params[$param] = $PSBoundParameters[$param]
        }
    }
    $params["UseBasicParsing"] = $true

    Microsoft.PowerShell.Utility\Invoke-WebRequest @params
}