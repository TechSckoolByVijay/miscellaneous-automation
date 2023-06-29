<#


This simple script demonstrates how PowerShell can be used to copy important configuration files from one location 
to multiple servers.

#>


cls
$servers = @(,"SERVER_W3V.domain.COM","SERVER_W4V.domain.COM","SERVER_W5V.domain.COM","SERVER_W6V.domain.COM","SERVER_W7V.domain.COM","SERVER_W8V.domain.COM")


foreach ($server in $servers){

Copy-Item  \\SOURCE_SERVER\D$\Main_Folder\SM_configuration.js \\$server\D$\Main_Folder\SM_configuration.js 
Copy-Item \\SOURCE_SERVER\D$\Main_Folder\ESS_configuration.js \\$server\D$\Main_Folder\ESS_configuration.js  
Copy-Item \\SOURCE_SERVER\D$\Main_Folder\Admin_configuration.js \\$server\D$\Main_Folder\Admin_configuration.js  
Copy-Item \\SOURCE_SERVER\D$\Main_Folder\DM_configuration.js \\$server\D$\Main_Folder\DM_configuration.js  
Copy-Item \\SOURCE_SERVER\D$\Main_Folder\rcp_custom.js \\$server\D$\Main_Folder\rcp_custom.js  

}

