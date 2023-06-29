#         Script Name : health_test.ps1
#
#        Developed By : Vijay Saini

#
#      Purpose : To assisit in upgrade activities
#		This script read the config file and point the module to approppriate application pool as per config file
#
#             
Remove-Variable * -ErrorAction SilentlyContinue

#Setting up variables
$BASE_DIR=(Resolve-Path .\).Path

$host_name=hostname

$settings_file=$BASE_DIR + "\iis_settings.conf"
$LOG_FILE=$BASE_DIR + "\iis_conf_export.log"
$nl = [Environment]::NewLine


try{
    foreach ($line in Get-Content $settings_file)
    {
    $tmp=$line.Split(',');
    $sitename=$tmp[0]
    $app_pool=$tmp[1]

   cmd.exe /c "%windir%\system32\inetsrv\appcmd.exe set app $sitename /applicationPool:$app_pool"
    }
} catch{
write-output "#ERROR1a# ErrorMessage : $ErrorMessage" | out-file $LOG_FILE -Append -Force;
write-output "#ERROR1a# FailedItem : $FailedItem" | out-file $LOG_FILE -Append -Force;
	
}