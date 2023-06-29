#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------
			
function export_source_db{
	
	$SQLServer = $var_Source_Server.Text;
	$DBName = $var_source_oltp.Text;
	$user_name=$var_source_db_user.Text;
	$db_password=$var_source_db_pass.Text;
	
	$db_arr=$var_source_oltp.Text,$var_source_wh.Text,$var_source_archive.Text,$var_source_pos.Text,$var_source_other.Text;


$datatable_source_details.Clear()

	foreach ($db in $db_arr) {
		
			$connectionString="Data Source=$SQLServer;Initial Catalog=$DBName;uid=$user_name;pwd=$db_password"
			$connection = New-Object -TypeName System.Data.SqlClient.SqlConnection($connectionString)
			$query = "set nocount on; SELECT DB_NAME(database_id) AS DatabaseName, Name AS Logical_Name, Physical_Name, (size*8)/1024 SizeMB FROM sys.master_files WHERE DB_NAME(database_id) = '$db'"
			$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $connection)
			$connection.Open()

			$Reader = $command.ExecuteReader()
			$datatable_source_details.Load($Reader)
			$Connection.Close()
		}
			
		$arr=$datatable_source_details | select DatabaseName,Logical_Name,Physical_Name,SizeMB
		$arr | export-csv "$ExportFile" -notypeinformation -Append -Force 
		write-output " " | out-file "$ExportFile"  -Append -Force 
		write-output " " | out-file "$ExportFile"  -Append -Force 
		
		
		
		$Datatable = New-Object System.Data.DataTable
			
			$query = "set nocount on; select top(1) version_number from rad_sys_db_version where database_name = '$DBName' order by last_modified_timestamp desc";
			$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $connection)
			$connection.Open()

				$Reader = $command.ExecuteReader()
				$Datatable.Load($Reader)
				
				$source_db_version=$Datatable | select-object -expand version_number
				
				set-variable -name source_db_version -value $source_db_version  -scope global
			
			
			$Datatable = New-Object System.Data.DataTable
					$query = "Use hosting_stats; select path from hs_paths where Path_name='tape_db_path'";
					$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $connection)
						
						$Reader = $command.ExecuteReader()
						$Datatable.Load($Reader)
						$source_backup_path=$Datatable | select-object -expand path;
						
				set-variable -name source_backup_path -value $source_backup_path  -scope global
			
			$Connection.Close()
			
	
}


function export_target_db{

		$SQLServer = $var_target_server.Text;
		$DBName = $var_target_oltp.Text;
		$user_name=$var_target_db_user.Text;
		$db_password=$var_target_db_pass.Text;
		
		$db_arr=$var_target_oltp.Text,$var_target_wh.Text,$var_target_archive.Text,$var_target_pos.Text,$var_target_other.Text;
		#write-output "Target Details" | out-file "prepWork.csv" -Append -Force; 
	
		$datatable_target_details.clear();
		
		
		foreach ($db in $db_arr) {
			$ExportSQL = "set nocount on; SELECT DB_NAME(database_id) AS DatabaseName, Name AS Logical_Name, Physical_Name, (size*8)/1024 SizeMB FROM sys.master_files WHERE DB_NAME(database_id) = '$db'" ;
 
		
			$connectionString="Data Source=$SQLServer;Initial Catalog=$DBName;uid=$user_name;pwd=$db_password"
			$connection = New-Object -TypeName System.Data.SqlClient.SqlConnection($connectionString)
			$query = "set nocount on; SELECT DB_NAME(database_id) AS DatabaseName, Name AS Logical_Name, Physical_Name, (size*8)/1024 SizeMB FROM sys.master_files WHERE DB_NAME(database_id) = '$db'"
			$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $connection)
			$connection.Open()

			$Reader = $command.ExecuteReader()
			$datatable_target_details.Load($Reader)
			$Connection.Close()
		}
			
		$arr=$datatable_target_details | select DatabaseName,Logical_Name,Physical_Name,SizeMB
		$arr | export-csv "$ExportFile" -notypeinformation -Append -Force 
		
			$Datatable = New-Object System.Data.DataTable
			
			$query = "set nocount on; select top(1) version_number from rad_sys_db_version where database_name = '$DBName' order by last_modified_timestamp desc";
			$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $connection)
			$connection.Open()
			$Reader = $command.ExecuteReader()
			$Datatable.Load($Reader)
			$target_db_version=$Datatable | select-object -expand version_number

	set-variable -name target_db_version -value $target_db_version  -scope global
	}


function Export_DB_Details_to_CSV{
	
	export_source_db
	sleep 4;
	export_target_db

}

	

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------



function get_disk_space_analysis($datatable_db_details)
{
	
			$driveletters_size = New-Object System.Collections.ArrayList;
			$drive_letter='';
			foreach ($db_details in $datatable_db_details){
				foreach ($data_file in $db_details){
				
						$db_name=$data_file.DatabaseName
						$logical_name=$data_file.Logical_Name
						$Physical_Name=$data_file.Physical_Name
						$SizeMB=$data_file.SizeMB
						
						$drive_l=$Physical_Name[0];
						$size=$SizeMB;
						$drive_letter +=",$drive_l";
						$driveletters_size.Add("$drive_l,$size");
						
						
						
					
				}
			}
			
			$driveletters_size=$driveletters_size.Trim()
			
			$drive_letter=$drive_letter.Trim()
			$drive_letter=$drive_letter -split ',';
			$drive_letters = $drive_letter | sort -unique
			
			
write-output "<table class='table'>" | out-file $html_file -Append -Force; 
write-output "<tr bgcolor='yellow'>" | out-file $html_file -Append -Force; 
write-output "<td><b>Drive</b></td>" | out-file $html_file -Append -Force; 
write-output "<td><b>Space Occupied(in MB)</b></td>" | out-file $html_file -Append -Force; 
write-output "<td><b>Space Occupied(in GB)</b></td>" | out-file $html_file -Append -Force; 
write-output "</tr>" | out-file $html_file -Append -Force; 

$total_in_mb=0;			
$total_in_gb=0;			
			foreach( $drive in $drive_letters){
				#echo $drive" drive"
				write-output "<tr>" | out-file $html_file -Append -Force; 
				write-output "<td>$drive Drive</td>" | out-file $html_file -Append -Force; 

				$this_drive_size_inMB=0;
				foreach( $dl_size in $driveletters_size){
						$t=$dl_size -split ',';
						$dl=$t[0];
						$ds=$t[1];
						if("$dl" -like "$drive"){ $this_drive_size_inMB += $ds; }	
				}
				#echo $this_drive_size;
				$this_drive_in_GB=$this_drive_size_inMB /1024;
				$this_drive_in_GB=[math]::round($this_drive_in_GB,2) 
				
				$total_in_mb+=$this_drive_size_inMB;
				$total_in_gb+=$this_drive_in_GB;
				write-output "<td> $this_drive_size_inMB </td>" | out-file $html_file -Append -Force; 
				
				write-output "<td>$this_drive_in_GB</td>" | out-file $html_file -Append -Force; 
				
				write-output "</tr>" | out-file $html_file -Append -Force; 

			}
write-output "<tr>" | out-file $html_file -Append -Force; 
write-output "<td><b>Total</b></td>" | out-file $html_file -Append -Force; 
write-output "<td>$total_in_mb</td>" | out-file $html_file -Append -Force; 
write-output "<td>$total_in_gb</td>" | out-file $html_file -Append -Force; 
write-output "</tr>" | out-file $html_file -Append -Force; 

write-output "</table>" | out-file $html_file -Append -Force; 

}


#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------


function get_db_memory_utilization($datatable_db_details){

	write-output "<table class='table'>" | out-file $html_file -Append -Force; 
	write-output "<tr bgcolor='yellow'>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Database Name</b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Space Occupied(in MB)</b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Space Occupied(in GB)</b></td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force; 
		
			
						
$total_in_mb=0;			
$total_in_gb=0;
	try{
	
$temp_dbnames=""
foreach ($db_details in $datatable_db_details){
	$tmp=$db_details.DatabaseName 
	$temp_dbnames = $temp_dbnames + "," + $tmp
	
	}
$unique_db_names=$temp_dbnames -split "," | sort-object | Get-Unique
	
	foreach ($databse in $unique_db_names){
				
					
		write-output "<tr>" | out-file $html_file -Append -Force; 
		write-output "<td>$databse</td>" | out-file $html_file -Append -Force; 
		
		$size_of_DBfiles_in_MB=0;
		foreach ($data_file in $datatable_db_details){
			$SizeMB=$data_file.SizeMB
			$DatabaseName=$data_file.DatabaseName
			if($DatabaseName -like "$databse"){
					$size_of_DBfiles_in_MB = $size_of_DBfiles_in_MB + $SizeMB
				}
		}
		
		$size_of_DBfiles_in_GB=$size_of_DBfiles_in_MB /1024;
		$size_of_DBfiles_in_GB=[math]::round($size_of_DBfiles_in_GB,2)	

		$total_in_mb+=$size_of_DBfiles_in_MB;
		$total_in_gb+=$size_of_DBfiles_in_GB;

				
		write-output "<td>$size_of_DBfiles_in_MB</td>" | out-file $html_file -Append -Force; 
		write-output "<td>$size_of_DBfiles_in_GB</td>" | out-file $html_file -Append -Force; 
				
		write-output "</tr>" | out-file $html_file -Append -Force; 

			}

		} catch{
	}
			
write-output "<tr>" | out-file $html_file -Append -Force; 
write-output "<td><b>Total</b></td>" | out-file $html_file -Append -Force; 
write-output "<td>$total_in_mb</td>" | out-file $html_file -Append -Force; 
write-output "<td>$total_in_gb</td>" | out-file $html_file -Append -Force; 
write-output "</tr>" | out-file $html_file -Append -Force; 

	write-output "</table>" | out-file $html_file -Append -Force; 

}

#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------


function get_diskResource_availability($AL_disk_details){

	write-output "<table class='table'>" | out-file $html_file -Append -Force; 
	write-output "<tr bgcolor='yellow'>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Drive</td><b>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Volume Label<b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Drice Size(in GB)<b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Free Space(in GB)<b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Free Space(in MB)<b></td>" | out-file $html_file -Append -Force; 
		write-output "<td><b>Free Space% <b></td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force; 
		

	try{
		foreach ($disk_detail in $AL_disk_details){
	
				write-output "<tr>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[0];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[1];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[2];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[3];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[4];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					$t=$disk_detail[5];
					write-output "<td>$t</td>" | out-file $html_file -Append -Force; 
					
				write-output "</tr>" | out-file $html_file -Append -Force; 
			}
		} catch{
	}

	write-output "</table>" | out-file $html_file -Append -Force; 

}




#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------------------------



Function Get-DiskInfo {
   
	$source_server_for_disk_analysis=$var_source_server_for_disk_analysis.text;
	$Credential='jdadelivers\101****'
	
	try{
	$dp = Get-WmiObject win32_logicaldisk -ComputerName $source_server_for_disk_analysis -Credential $Credential |  Where-Object {$_.drivetype -eq 3} 
	}catch{
		$ErrorMessage = $_.Exception.Message
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Error: $nl Message: $ErrorMessage",0,"OK",0x1)
	}
	$AL_diskSpace_details.clear();
	 for ($i = 0; $i -lt $dp.Count; $i++){ 
	 
		$DeviceID=$dp[$i].DeviceID
		$label=$dp[$i].VolumeName
		$totSpace=[math]::Round(($dp[$i].Size/1073741824),2) 
		$frSpace_gb=[Math]::Round(($dp[$i].FreeSpace/1073741824),2)
		$frSpace_mb=$frSpace_gb *1024
		
		$freePercent = ($frSpace_gb/$totSpace)*100 
		$freePercent = [Math]::Round($freePercent,0) 
	 # $dp[$i] | Select @{ name="drive";ex={$DeviceID}},@{ name="volume_label";ex={$label}} ,@{ name="drive_size";ex={$totSpace}}           |% {$var_listView.addchild($_)}
		 $dp[$i] | Select @{ name="drive";ex={$DeviceID}},@{ name="volume_label";ex={$label}},@{ name="drive_size";ex={$totSpace}},@{ name="free_space_mb";ex={$frSpace_mb}}, @{ name="free_space_gb";ex={$frSpace_gb}}, @{ name="free_space_percent";ex={$freePercent}}  |% {$var_listView.addchild($_)}
		$arr=@($DeviceID,$label,$totSpace,$frSpace_gb,$frSpace_mb,$freePercent);

	 $AL_diskSpace_details.Add($arr);
 }
 
 }
 
 
		
 #===========================================================================================================================================
 #===========================================================================================================================================
 #===========================================================================================================================================
