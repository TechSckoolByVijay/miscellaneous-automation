<#
This script is to demonstrate how PowerShell can be used to pull the user account of a service running on remote machine

This is a pull proof script and it do not throw error even if the service is not installed on the machine

#>


$content = Get-Content "server_list.txt"
$nl = [Environment]::NewLine
$output_file='output.csv'
echo "">$output_file

$error_count=0;



function Confirm-WindowsServiceExists($server_name, $service_name)
{   

   if (Get-Service -Name $service_name -Computername $server_name -ErrorAction SilentlyContinue -ErrorVariable WindowsServiceExistsError)
   {
      # Write-Host "$name Exists on $server"
	  
       return $true
   }

   

   return $false
}



$arr_services = @("IISADMIN","Tomcat7","SOME_Service")
foreach ($server_name in $content) {

	foreach ($service_name in $arr_services){
		
			
		if(Confirm-WindowsServiceExists "$server_name" "$service_name"  ){
			$status_tmp=(Get-Service -Name $service_name -ComputerName $server_name).Status;
			
			$tmp=cmd.exe /c "sc \\$server_name qc $service_name | findstr SERVICE_START_NAME" 
			$service_startname = $tmp -replace "SERVICE_START_NAME :",'' 
			$service_startname=$service_startname.ToString()
			$service_startname=$service_startname.Trim()


			$tmp=cmd.exe /c "sc \\$server_name qc $service_name | findstr START_TYPE" 

			$output_into_single_file_enable = $line -replace "OUTPUT_INTO_SINGLE_FILE_ENABLE:-",'' 
			$start_type = $tmp -replace "START_TYPE         :",'' 
			$start_type=$start_type.ToString()
			$start_type=$start_type.Trim()
          
				echo  "$server_name, $service_name , $status_tmp , $service_startname , $start_type" >> $output_file
				
			
		} else {
				echo  "$server_name, $service_name , NA , NA , Service not found" >> $output_file
			}	
		}
		
	
}


