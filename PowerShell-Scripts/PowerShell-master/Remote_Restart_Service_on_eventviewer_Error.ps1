#   Script Name : RestartAPP_on_--PARTICULAR--_Error.ps1
#
#   Developed By : Vijay Saini
#  	Scripting Language : PowerShell
#
#
#   Purpose : To restart the APP service if --PARTICULAR-- error detected in event viewer 
#
# The script is aimed to restart a particular service if it find a particular event occurred in Event Viewer
# This script can be executed continously from task scheduler and it can help in ensuring smooth run of your application by self healing
#   
#Setting up variables
$BASE_DIR=(Resolve-Path .\).Path
$ddMMyyyy=(Get-Date).ToString('dd-MM-yyyy');
$LOG_FILE=$BASE_DIR + "\OUTPUT\--PARTICULAR--_error-"+$ddMMyyyy +".log"


write-output "$(get-date) : Checking for --PARTICULAR-- error " | out-file $LOG_FILE -Append -Force; 

$--PARTICULAR--_error_count = (Get-EventLog -LogName Application   -After (Get-Date).AddMinutes(-5) | 
                    Where-Object {$_.Message -like "*--PARTICULAR--*"} | measure).count

if($--PARTICULAR--_error_count -ge 1){
	write-output "$(get-date) : --PARTICULAR-- error detected " | out-file $LOG_FILE -Append -Force; 

	write-output "$(get-date) : Stopping the APP service " | out-file $LOG_FILE -Append -Force; 

	Stop-Service -Name APPService -WhatIf
	sleep 60
	write-output "$(get-date) : Killing APP processes " | out-file $LOG_FILE -Append -Force; 
	Stop-Process -Name "APP" -WhatIf

	write-output "$(get-date) : Starting the APP service " | out-file $LOG_FILE -Append -Force; 

	Start-Service -Name APPService -WhatIf
 
} else {
    write-output "$(get-date) : --PARTICULAR-- error NOT found " | out-file $LOG_FILE -Append -Force; 
  
}

write-output "$(get-date) : Script Execution Over " | out-file $LOG_FILE -Append -Force; 
