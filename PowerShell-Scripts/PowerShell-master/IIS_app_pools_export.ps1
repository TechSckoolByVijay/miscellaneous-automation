#         Script Name : health_test.ps1
#
#        Developed By : Vijay Saini
#  Scripting Language : PowerShell
#
#                Date : 8th February 2017
#
#             Purpose : To assisit in upgrade activities
#		Thi script export the application pool pointing to configuration file
#
#             
Remove-Variable * -ErrorAction SilentlyContinue

#Setting up variables
$BASE_DIR=(Resolve-Path .\).Path

$host_name=hostname

$settings_file=$BASE_DIR + "\iis_settings.conf"
$LOG_FILE=$BASE_DIR + "\iis_conf_export.log"
$nl = [Environment]::NewLine


$tmp_list_sites=cmd.exe /c "%windir%\system32\inetsrv\appcmd list app"

try{
echo "Application_Name , Application_Pool">$settings_file
foreach ($site in $tmp_list_sites){

$tmp=$site.ToString();
$tmp=$tmp -split "applicationPool:"
$first=$tmp[0]
$sitename=($first -split "`"")[1];
#$sitename
#echo "Site Name: "$a[1]
$second=$tmp[1]
$app_pool=$second.Trim('`)');

echo "$sitename,$app_pool" >> $settings_file

}
} catch{
write-output "#ERROR1a# ErrorMessage : $ErrorMessage" | out-file $LOG_FILE -Append -Force;
write-output "#ERROR1a# FailedItem : $FailedItem" | out-file $LOG_FILE -Append -Force;
	
}