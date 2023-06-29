<#

This script demonstrates WebAdministration for remote IIS management.

If we have to get IIS related information from multiple servers, we can use this module remotely

#>

$servers= @("SERVER_W1V.domain.COM","SERVER_W2V.domain.COM","SERVER_W3V.domain.COM","SERVER_W4V.domain.COM","SERVER_W5V.domain.COM","SERVER_W6V.domain.COM","SERVER_W7V.domain.COM","SERVER_W8V.domain.COM","SERVER_A10V.domain.COM","SERVER_A1V.domain.COM","SERVER_A2V.domain.COM","SERVER_A3V.domain.COM","SERVER_A4V.domain.COM","SERVER_A5V.domain.COM","SERVER_A6V.domain.COM","SERVER_A7V.domain.COM","SERVER_A8V.domain.COM","SERVER_A9V.domain.COM")

foreach ($server in $servers){
" $server"


Invoke-Command -ComputerName $server -ScriptBlock {

Import-Module WebAdministration;

    Get-ChildItem  -Path IIS:\AppPools\ | 
    Select-Object name, state, managedRuntimeVersion, managedPipelineMode, @{e={$_.processModel.username};l="username"}, 
     @{e={$_.processModel.identityType};l="identityType"} |
    format-table -AutoSize
}

}