<#

This script demontrates how eventviewer can be accessed using PowerShell

#>


$provider = New-Object System.Globalization.CultureInfo "en-US"
$dateTimeString="07/10/2018 22:00";
$startTime = [datetime]::ParseExact($dateTimeString, 'MM/dd/yyyy HH:mm', $provider)


$endTime = $startTime.AddHours(1) 


Get-EventLog -Log "Application" -EntryType Error -After $startTime -before $endTime
