<#

Purpose:
This script is demonstrates how IIS web server management can be done using PowerShell. 

WebAdministration is an important module for managing IIS using PowerShell.

Install this module into your PowerShell using Import-Module WebAdministration and then you can manage your IIS websites using this.
#>

Import-Module WebAdministration


$apppoolname = 'app_pool_name'
$sitename='my_website'

#Creating the application pool
New-WebAppPool -Name $appPoolName 


#Creating IIS applications(persona modules) and pointing to the correct application pool
New-WebApplication -Name 'WS-Admin' -Site $sitename -PhysicalPath 'C:\SiteMasterFolder\IIS\Admin' -ApplicationPool $apppoolname 
New-WebApplication -Name 'WS-Worker' -Site $sitename -PhysicalPath 'C:\SiteMasterFolder\IIS\Worker' -ApplicationPool $apppoolname 