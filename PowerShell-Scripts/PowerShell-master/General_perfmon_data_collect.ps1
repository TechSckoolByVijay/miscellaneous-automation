#   Script Name : permon_data_collect.ps1
#
#   Developed By : Vijay Saini
#  	Scripting Language : PowerShell
#
#   Date : 22nd June 2018
#
#   Purpose : To remotely setup the performance counters and pull the report in CSV format
#
#
#   
#Setting up variables
$BASE_DIR=(Resolve-Path .\).Path
$ddMMyyyy=(Get-Date).ToString('dd-MM-yyyy');
$LOG_FILE=$BASE_DIR + "\OUTPUT\perfmon_log-"+$ddMMyyyy +".log"


$Centralized_Repository = "\\CENTRALIZED_SERVER\c$\centralized_perfmon_data"

write-output "$(get-date) : Starting the script " | out-file $LOG_FILE -Append -Force; 

$pwd = (Resolve-Path .\).Path
$counters = @(gc $pwd\perfmon_counters.ini) # List of counters one per line
$servers = @(gc $pwd\server_list.ini) # List of remote computers one per line

$frequence = "00:00:05" #hh:mm:ss
$logtype = "bincirc" # possibles: bin,bincirc,csv,tsv

$max_duration = "168:00:00" # 7 days
$max_size = "50" # megabytes

$l = $servers.length

$i = 0




foreach ($server in $servers) {

write-output "$(get-date) : Processing on $server  " | out-file $LOG_FILE -Append -Force; 

    $counters | % {$_ -replace "SERVER", "\\$server"} | Set-Content $pwd\$server.txt
   # Write-Progress -Activity "Setting up Collections...." -Status "Collection: $i of $l" -PercentComplete (100*$i/$l)
    
    
    write-output "$(get-date) : Deleteing perfmon perf_$server on $server " | out-file $LOG_FILE -Append -Force;
       $strCMD = "C:\Windows\System32\logman.exe delete perf_$server -s $server"
    Invoke-Expression $strCMD


    $timestamp=(Get-Date).ToString('ddMMyyyy_hhmmss');
    $output_perf_file = "C:\PerfLogs\perf_$server"
    $strCMD1 = "C:\Windows\System32\logman.exe create counter perf_$server -s $server -si $frequence -cf $pwd\$server.txt -f $logtype -v mmddhhmm -o $output_perf_file -rf $max_duration -max $max_size"
    $i++

    Invoke-Expression $strCMD1

    Start-Sleep 2
    
     write-output "$(get-date) : Staring perfmon perf_$server on $server " | out-file $LOG_FILE -Append -Force;
    $startprocess = Invoke-WmiMethod -ComputerName $server -Class Win32_Process -Name Create -ArgumentList "logman.exe start perf_$server"
    #Remove-Item $pwd\$server.txt
  
    Start-Sleep 30

   write-output "$(get-date) : Stopping perfmon perf_$server  on $server" | out-file $LOG_FILE -Append -Force;
   $startprocess = Invoke-WmiMethod -ComputerName $server -Class Win32_Process -Name Create -ArgumentList "logman.exe stop perf_$server"
   
   Start-Sleep 5

   #$startprocess = Invoke-WmiMethod -ComputerName $server -Class Win32_Process -Name Create -ArgumentList "logman.exe stop perf_$server"
  
  # relog SERVERBASELINE_000001.blg -c "\Memory\Available MBytes" -f csv -o sslogfile.csv

  write-output "$(get-date) : File Successfully posted to centralized location from $server" | out-file $LOG_FILE -Append -Force; 
#  Move-Item  $output_perf_file -Destination $Centralized_Repository
  Move-Item  -Path  "\\$server\C$\PerfLogs\perf*.blg"  -Destination $Centralized_Repository

  write-output "$(get-date) : processing completed for  $server" | out-file $LOG_FILE -Append -Force;
}
