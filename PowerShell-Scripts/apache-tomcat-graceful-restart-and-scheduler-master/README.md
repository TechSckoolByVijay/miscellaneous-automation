# apache-tomcat-graceful-restart-and-scheduler



The script is intend to schedule any service restart on a server. Just add the service name in the powershell script and it is good to consider the service for restart.

Trigger to schedule the powershell script in task scheduler ->  tomcatrestart.bat 

Script is programmed to try $max_trial_allowed number of time and will sleep for $sleeptime seconds before every new trial. Still if the service status do not change, then it can shoot an email to the support team.

Every run of the powershell script will be logged in the SERVERNAME_apache_Restart_Log.log with timestamp



Feel free to use it as per you requirement. Please contact me at VijaySainiProfessional@gmail.com to understand it in more details



For advanced version of this script, please visit https://github.com/SainiVijayProgram/advanced-services-restart-scheduler--notification-emails-included-
