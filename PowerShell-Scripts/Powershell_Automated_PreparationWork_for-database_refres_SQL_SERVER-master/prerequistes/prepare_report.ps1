function prepare_html_report(){
"">$html_file
write-output "<html><br>" | out-file $html_file -Append -Force; 
write-output "<body><br>" | out-file $html_file -Append -Force;

$style="<style type='text/css'>
table.table {
	font-family: verdana,arial,sans-serif;
	font-size:13px;
	color:#333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}
table.table th {
	background-color:#c3dde0;
	font-size:14px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
table.table tr {
	background-color:#d4e3e5;
}
table.table td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
</style>"
write-output "$style" | out-file $html_file -Append -Force; 



write-output "" | out-file $html_file -Append -Force; 
write-output "<font color='brown'>Hi Team,</font>" | out-file $html_file -Append -Force; 
write-output  "<br><br><br>" | out-file $html_file -Append -Force;
write-output  "<font color='brown'>Please find prep work for the upcoming activity below.</font> <br><Br>" | out-file $html_file -Append -Force;




write-output "<table class='table'>" | out-file $html_file -Append -Force; 
	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Activity Type</b></td>" | out-file $html_file -Append -Force; 
	$tmp=$var_activity_type.text;
	write-output "<td>$tmp</td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Scheduled Date</b></td>" | out-file $html_file -Append -Force; 
	$tmp=$var_scheduled_date.text;
	write-output "<td> $tmp </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Case number</b></td>" | out-file $html_file -Append -Force; 
	$tmp=$var_case_number.text;
	write-output "<td> $tmp</td> "| out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Source Server</b></td>" | out-file $html_file -Append -Force; 
	$tmp=$var_source_server.text;
	write-output "<td> $tmp </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;


	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Source DB Version</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td> $source_db_version</td>" | out-file $html_file -Append -Force;
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Target Server</b></td>" | out-file $html_file -Append -Force; 
	$tmp=$var_target_server.text;
	write-output "<td> $tmp </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Target DB Version</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td> $target_db_version</td>" | out-file $html_file -Append -Force;
	write-output "</tr>" | out-file $html_file -Append -Force;
	
	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Backup Path</b></td>" | out-file $html_file -Append -Force; 
	
	$t=$source_backup_path
	write-output "<td>  $t </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;


	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Backup Size</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	
	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Refresh Server</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Available Full Backup Date</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Available Diff Backup Date</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Space required in drives</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Upgrading Version</b></td>" | out-file $html_file -Append -Force; 
	if("$source_db_version" -like "$target_db_version"){
			write-output "<td>No </td>" | out-file $html_file -Append -Force; 
		} else {
		write-output "<td><b>Yes </b></td>" | out-file $html_file -Append -Force; 
	}
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "<tr>" | out-file $html_file -Append -Force; 
	write-output "<td><b>Copied Package path</b></td>" | out-file $html_file -Append -Force; 
	write-output "<td>  ********** </td>" | out-file $html_file -Append -Force; 
	write-output "</tr>" | out-file $html_file -Append -Force;

	write-output "</table>" | out-file $html_file -Append -Force;


#------------------------------------------------------------------------
#------------------------------------------------------------------------

write-output  "<br><br><br>" | out-file $html_file -Append -Force;


write-output  "<style>" | out-file $html_file -Append -Force;
	write-output  " #container{width:1020px;}" | out-file $html_file -Append -Force;
	write-output  " #left{float:left;width:500px;}" | out-file $html_file -Append -Force;
	write-output  " #right{float:right;width:500;}" | out-file $html_file -Append -Force;
	write-output  " #center{margin:0 auto;width:20px;}" | out-file $html_file -Append -Force;
write-output  "</style>" | out-file $html_file -Append -Force;


write-output  "<b><font color='brown'>Space Occupied by data files(Disk wise)</font><br></b>" | out-file $html_file -Append -Force; 
	
write-output  "<div id='container'>" | out-file $html_file -Append -Force; 
	write-output  "<div  id='left'>" | out-file $html_file -Append -Force; 
		write-output  "<font color='brown'><b>Source</b></font>" | out-file $html_file -Append -Force; 
		get_disk_space_analysis($datatable_source_details)
	write-output  "</div>" | out-file $html_file -Append -Force; 

	write-output  "<div  id='center'></div>" | out-file $html_file -Append -Force; 
	
	write-output  "<div id='right'>" | out-file $html_file -Append -Force; 
		write-output  "<font color='brown'><b>Target</b></font>" | out-file $html_file -Append -Force; 
		
		get_disk_space_analysis($datatable_target_details)		
	write-output  "</div>" | out-file $html_file -Append -Force; 
write-output  "</div>" | out-file $html_file -Append -Force; 
	
#------------------------------------------------------------------------
#------------------------------------------------------------------------

write-output  "<hr style='clear:both;'>" | out-file $html_file -Append -Force; 

write-output "<br><br><br><br>" | out-file $html_file -Append -Force; 
write-output "<b><font color='brown'>Space Occupied by data files(Database wise)</font></br></b>" | out-file $html_file -Append -Force; 

write-output  "<div id='container'>" | out-file $html_file -Append -Force; 
write-output  "<div  id='left'>" | out-file $html_file -Append -Force; 
	write-output  "<font color='brown'><b>Source</b></font>" | out-file $html_file -Append -Force; 
	get_db_memory_utilization($datatable_source_details);
write-output  "</div>" | out-file $html_file -Append -Force; 

	write-output  "<div  id='center'></div>" | out-file $html_file -Append -Force; 
	
	write-output  "<div id='right'>" | out-file $html_file -Append -Force; 
		write-output  "<font color='brown'><b>Target</b></font>" | out-file $html_file -Append -Force; 
		get_db_memory_utilization($datatable_target_details);
	write-output  "</div>" | out-file $html_file -Append -Force; 
	write-output  "</div>" | out-file $html_file -Append -Force; 
write-output  "<hr style='clear:both;'>" | out-file $html_file -Append -Force; 

#------------------------------------------------------------------------
#------------------------------------------------------------------------



write-output "<br><br><br><br>" | out-file $html_file -Append -Force; 
write-output "<b><font color='brown'>Disk Resouce Availabilty</font></b>" | out-file $html_file -Append -Force; 
if ($AL_diskSpace_details.count -gt 0){
	get_diskResource_availability($AL_diskSpace_details);
} else{
write-output "<br><b><font color='red'> Data not available</font></b>" | out-file $html_file -Append -Force; 
}
#------------------------------------------------------------------------
#------------------------------------------------------------------------

write-output "<br><b><font color='brown'><bR><Br>Regards,<br> ESO App Team</font></b>" | out-file $html_file -Append -Force; 

}