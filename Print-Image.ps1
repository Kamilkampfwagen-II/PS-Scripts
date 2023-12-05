function Print-Image {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$ImagePath,
        [string]$PrinterName
    )

    $fullImagePath = (Get-Item $ImagePath).FullName
    if (!$PrinterName) {
        $PrinterName = (Get-WmiObject -Query "Select * From Win32_Printer Where Default=$true").Name
    }

    # This already has error handling. Nothing bad happens if either of those parameters are invalid.
    rundll32 shimgvw.dll ImageView_PrintTo /pt $fullImagePath $PrinterName
}