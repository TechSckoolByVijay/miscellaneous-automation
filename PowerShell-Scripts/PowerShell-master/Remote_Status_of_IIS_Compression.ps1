<#

This script is checking if IIS static and dynamic compression is enabled or not on multiple servers

The script is executing an APPCMD command using command prompt and then getting the data into PowerShell

#>


Write-Host "ComputerName, Synamic Compression,  Static Compression"

$computers = @("SERVER_41v","SERVER_42v","SERVER_43v","SERVER_44v","SERVER_45v","SERVER_46v","SERVER_47v","SERVER_48v","SERVER_49v","SERVER_50v","SERVER_51v","SERVER_52v","SERVER_53v","SERVER_54v","SERVER_55v","SERVER_56v","SERVER_57v","SERVER_58v","SERVER_59v","SERVER_60v","SERVER_61v","SERVER_62v","SERVER_63v","SERVER_64v","SERVER_65v","SERVER_66v","SERVER_67v","SERVER_68v","SERVER_69v","SERVER_70v")
foreach ($computer in $computers){
 $dynamic_enabled = "null"
 $static_enabled     ="null"

 Write-Host $computer -NoNewline -ForegroundColor red -BackgroundColor Yellow
Invoke-Command -ComputerName $computer  -ScriptBlock {

    [xml]$config = cmd /s /c "$env:WINDIR\system32\inetsrv\appcmd.exe" list config /section:urlCompression 
    
    $config.GetElementsByTagName('urlCompression')
    $dynamic_enabled =($config.GetElementsByTagName('urlCompression')).doDynamicCompression
    $static_enabled =($config.GetElementsByTagName('urlCompression')).doStaticCompression
    
    echo " $dynamic_enabled , $static_enabled" 
    }
#echo "$computer , $dynamic_enabled , $static_enabled" 

}

