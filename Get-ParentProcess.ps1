function Get-ParentProcess {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$ProcessId
    )

    if (!$ProcessId) {
        $ProcessId = $PID
    }

    $parentPID = (Get-CimInstance -Class Win32_Process -Filter "ProcessId = '$ProcessId'").ParentProcessId
    # return Get-CimInstance -Class Win32_Process -Filter "ProcessId = '$parentPID'"
    return Get-Process -PID $parentPID
}