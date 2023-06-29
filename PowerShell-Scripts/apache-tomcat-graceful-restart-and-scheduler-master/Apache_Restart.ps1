#         Script Name : apache_restart.ps1
#
#                             Developed By: Vijay Saini
#  Scripting Language : PowerShell
#
#                Date : 2nd August 2016
#
#             Purpose : Stop and start Apache services gracefully
#
#
#             

#Setting up variables
$BASE_DIR=(Resolve-Path .\).Path
$host_name=hostname
$LOG_FILE=$BASE_DIR + "\" +$host_name + "_apache_Restart_Log.log"
$no_of_try=0
$max_trial_allowed=4
$sleeptime =30;
$nl = [Environment]::NewLine



#This part of code deals with stopping apache services gracefully.
#It will make sure that until apache serives are down, start should not be attempted.
 
write-output "$(get-date) : Staring the script " | out-file $LOG_FILE -Append -Force;  

write-output "$(get-date) : Step1: Current status of Tomcat Service:- $($(get-service -ComputerName localhost -Name Tomcat*).Status)" | out-file $LOG_FILE -Append -Force; 

while (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -notlike "Stopped")
{

	$no_of_try++
		
	  # If the no of retries exceed 3, breaking the loop
	  if ( $no_of_try -gt $max_trial_allowed )
	  {
		write-output "$(get-date) : Quitting STOP after $max_trial_allowed tries  " | out-file $LOG_FILE -Append -Force; 
		break
	  }

	   If (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -notlike "Stopped"){
	   
					If (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -like "StopPending"){
				
						write-output "$(get-date) : Stop is Pending. Will check again after $sleeptime seconds " | out-file $LOG_FILE -Append -Force; 
						sleep $sleeptime
					} else {
						Try{
								write-output "$(get-date) : Service is neither stopped nor in pending status. Hence attempting to Stop " | out-file $LOG_FILE -Append -Force; 
								(Get-Service -Name Tomcat* -ComputerName localhost).Stop()
                                sleep $sleeptime
						}Catch{
								write-output "$(get-date) : Stop command failed  " | out-file $LOG_FILE -Append -Force; 
								Break
						}
					}
	} else {
				write-output "$(get-date) : Service was found in stopped status. Hence proceeding to start " | out-file $LOG_FILE -Append -Force; 
				break
	}
}
  
write-output "$(get-date) : Step2: Status Before attempting start:- $($(get-service -ComputerName localhost -Name Tomcat*).Status)" | out-file $LOG_FILE -Append -Force; 

$no_of_try=0

If (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -like "Stopped"){
	
	while (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -notlike "Running")	{
		$no_of_try++
			
		  # If the no of retries exceed 3, breaking the loop
		  if ( $no_of_try -gt $max_trial_allowed )
		  {
			write-output "$(get-date) : Quitting START after $max_trial_allowed tries  " | out-file $LOG_FILE -Append -Force; 
			break
		  }

		   If (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -notlike "Running"){
		   
						If (((Get-Service -Name Tomcat* -ComputerName localhost).Status) -like "StartPending"){
					
							write-output "$(get-date) : Start is Pending(In Progress). Will check again after $sleeptime seconds " | out-file $LOG_FILE -Append -Force; 
							sleep $sleeptime
						} else {
							Try{
									write-output "$(get-date) : Service is neither running nor the start is pending. Hence attempting to Start " | out-file $LOG_FILE -Append -Force; 
									(Get-Service -Name Tomcat* -ComputerName localhost).Start()
                                    sleep $sleeptime
							}Catch{
									write-output "$(get-date) : Start command failed  " | out-file $LOG_FILE -Append -Force; 
									Send-MailMessage -From ExpensesBot@MyCompany.Com -To WinAdmin@MyCompany.Com -Subject "HR File Read Failed!" -SmtpServer EXCH01.AD.MyCompany.Com
									Break
							}
						}
			} else {
					write-output "$(get-date) : Service was found in running status. Hence Exiting " | out-file $LOG_FILE -Append -Force; 
					break
		}
	}
}else{
	write-output "$(get-date) : Tomcat Service could not be stopped normally hence exiting without attempting to start  " | out-file $LOG_FILE -Append -Force; 		
}

write-output "$(get-date) : Step3: Final status of Tomcat Service before script exit:- $($(get-service -ComputerName localhost -Name Tomcat*).Status)" | out-file $LOG_FILE -Append -Force; 

write-output "$_$nl$_$nl" | out-file $LOG_FILE -Append -Force; 
