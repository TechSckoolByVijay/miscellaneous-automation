#******************************************************************
#******************************************************************
#******************************************************************
#Project: Automation of Prep Work(Bizops)
#Covered for: DB Refresh & DB Upgrade
#
#Developed By: Vijay Saini
#Email: Vijay.Saini@***.com
#Date: 27th September 2016
#
#******************************************************************
#******************************************************************
#******************************************************************

Remove-Variable * -ErrorAction SilentlyContinue
$ddMMyyyy=(Get-Date).ToString('dd-MM-yyyy');

$BASE_DIR=(Resolve-Path .\).Path
$html_file=$BASE_DIR + "\OUTPUT\prep_work_"+$ddMMyyyy+".html"
$ExportFile = $BASE_DIR + "\OUTPUT\prep_work_"+$ddMMyyyy+".csv"
$nl = [Environment]::NewLine

#-- These datatables are getting populated from click on Export button
$datatable_source_details = New-Object System.Data.DataTable
$datatable_target_details = New-Object System.Data.DataTable
$AL_diskSpace_details = New-Object System.Collections.ArrayList;


try{
#calling the function library
. "prerequistes\functions.ps1"
. "prerequistes\prepare_report.ps1"

#Calling the UI components library
. "prerequistes\ui_elements.ps1"
}catch{
		$ErrorMessage = $_.Exception.Message
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Error: $nl Message: $ErrorMessage",0,"OK",0x1)
	}

#******************************************************************
#******************************************************************
#******************************************************************