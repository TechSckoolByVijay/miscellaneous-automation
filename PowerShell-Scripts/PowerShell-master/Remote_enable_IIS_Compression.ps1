<#
This script can be used to enable/disable IIS static and dynamic compression 
on multiple remote machine

#>

$computers = @("Server1","Server2")

Invoke-Command -ComputerName $computers  -ScriptBlock {


$source="D:\EPS\DeployedFiles\walmart-nhm-wfmr\WebDeploy\Web.config"
Set-ItemProperty -Path $source -Name IsReadOnly -Value $false

echo "Enabling the compression "
$tmp = cmd /s /c "c:\windows\system32\inetsrv\appcmd set config  -section:system.webServer/urlCompression /doDynamicCompression:True"
$tmp
$tmp = cmd /s /c "c:\windows\system32\inetsrv\appcmd.exe set config -section:system.webServer/urlCompression /doStaticCompression:True"
$tmp
$source="D:\EPS\DeployedFiles\walmart-nhm-wfmr\WebDeploy\Web.config"
Set-ItemProperty -Path $source -Name IsReadOnly -Value $true


}

