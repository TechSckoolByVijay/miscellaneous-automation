#!/bin/ksh
# Program: chousekeeping.ksh
# Original Created by:Vijay Saini
# Purpose1: Remove Archive files older than the specified number of days. Created as part of Allocation Template.
# Purpose2: Zip the result files generated on a day and keep themi one directory
# Version : 1.0  
# Dependencies:
#      1. Environment should be set
#      
#
# Modification History:
#
#  When    		 Who       	 What
# ----------------------------------------------------------------------------------------------- 
#  22 Dec 2015    Vijay Saini     Developed a new housekeeping logic 
 -----------------------------------------------------------------------------------------------
# 
# 
#

#Set Environment Variables

export NUMBER_ARCHIVE_DAYS=30
export GRADE_RETENTION=30

#No of days for which we do not want to zip the folder
export FOLDER_RETENTION=30

export OUTBOX_RETNETION_DAYS=30
export FOLDER_ZIPPING_DAYS=2
export RESULT_FILES_NO_ZIPPING=2
export RESULT_FILE_ZIPING=5
export OUTBOX=/data/amisdev/CCR_Allocation/vijay_devp/Outbox
export LOGFILEPATH=/data/amisdev/CCR_Allocation/vijay_devp/log
export ARCHIVE_DIR=/data/amisdev/CCR_Allocation/vijay_devp/Archive

#Redirect STDOUT to a logfile 
exec 1>$LOGFILEPATH/custom_archive_cleanup.log

#REdirect STDERR to a debug file
exec 2>$LOGFILEPATH/custom_archive_cleanup.log
 
 
#delete all FOLDERS IN ARCHIVE FOLDER which were last modified older than the number of days passed as a parameter
echo "Deleting Old folders in archive" >> $LOGFILEPATH/custom_archive_cleanup.log
find $ARCHIVE_DIR/* -type d -mtime +$NUMBER_ARCHIVE_DAYS -exec rm -rf {} \; > $LOGFILEPATH/custom_archive_cleanup.log

#delete all FILES IN ARCHIVE FOLDER which were last modified older older than the number of days passed as a parameter
# This is to delete grade logfile and zip(including results and grades) files older then the passed parameter 
echo "Deleting Old Files in archive" >> $LOGFILEPATH/custom_archive_cleanup.log
find $ARCHIVE_DIR/* -type f -mtime +$NUMBER_ARCHIVE_DAYS -exec rm -rf {} \; >> $LOGFILEPATH/custom_archive_cleanup.log



#Transfer the control to Archive folder`
	cd $ARCHIVE_DIR
	echo "Current directory:"`pwd`>>$LOGFILEPATH/custom_archive_cleanup.log

#ZIP all folders which were last modified older older than the number of days passed as a parameter FOLDER_ZIPPING_DAYS
echo "Zipping Old folders in archive " >> $LOGFILEPATH/custom_archive_cleanup.log
for folder in `find 2* -type d -mtime +$FOLDER_RETENTION -print`
do
	echo "Making a Zip of folder $folder  " >>$LOGFILEPATH/custom_archive_cleanup.log
	zip -r $folder.zip $folder 

	echo "Deleting the folder $folder" >>$LOGFILEPATH/custom_archive_cleanup.log
	rmdir $folder
done;

#Zipping  grade files
echo "Zipping grade files in archive " >> $LOGFILEPATH/custom_archive_cleanup.log
for file in `find Grade.csv* -type f -print`
do
	echo "Making a Zip of file $file " >>$LOGFILEPATH/custom_archive_cleanup.log
	zip  $file.zip $file 

	echo "Deleting the file $file " >>$LOGFILEPATH/custom_archive_cleanup.log
	rm -f $file 
done;
	#Transfer the control to Back to Scripts folder`
	cd -
	echo "Current directory:"`pwd`>>$LOGFILEPATH/custom_archive_cleanup.log



# At this point we dont have any file or folder in ARCHIVE folder which has not been modified in last NUMBER_ARCHIVE_DAYS days.
 

#delete all FILES IN OUTBOX which were last modified older older than the number of days passed as a parameter 
echo "Deleting Old files in Outbox" >> $LOGFILEPATH/custom_archive_cleanup.log
find $OUTBOX/* -type f -mtime +$OUTBOX_RETNETION_DAYS -exec rm -rf {} \; >> $LOGFILEPATH/custom_archive_cleanup.log

#delete all FOLDERS IN OUTBOX which were last modified older older than the number of days passed as a parameter 
echo "Deleting Old folders in Outbox" >> $LOGFILEPATH/custom_archive_cleanup.log
find $OUTBOX/* -type d -mtime +$OUTBOX_RETNETION_DAYS -exec rm -rf {} \; >> $LOGFILEPATH/custom_archive_cleanup.log


# At this point we dont have any file or folder in OUTBOX folder which has not been modified in last NUMBER_ARCHIVE_DAYS days.
 
 
 
 
 	echo "----------------------------------------------------------------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
	echo "---------------------LOGIC FOR RESULTS FILES in ARCHIVE DIRECTORY---------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
	echo "----------------------------------------------------------------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
			
 
 
# Result files archiving in ARCHIVE DIRECTORY 
# Zip all result files generated on a particular date into yyyymmdd.zip
#format of timestamp yyyymmddhh
current_timestamp=`date "+%Y%m%d"`
echo "CURRENT_TIMESTAMP: $current_timestamp " >>$LOGFILEPATH/custom_archive_cleanup.log

tmp=$(($current_timestamp - 3 ))
echo "Temp: $tmp Result files created before this date will only be zipped" >>$LOGFILEPATH/custom_archive_cleanup.log

		#Upto this time stamp we can zip the files
		#If today is 20151222 in yymmdd format, then value of z_time will be 20151220
		z_time=$tmp
		
				
		echo "----------------------------------------------------------------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		echo "----------------------------------Entering the for loop-----------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		echo "-----------------Here I will zip the result files which starts with art* and are older then 2 days -----------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		echo "-----------------Will go for five iterations only  since it is a weekly job-----------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		echo "----------------- --------------- --------------- -----------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		
	#Transfer the control to Archive folder`
	cd $ARCHIVE_DIR
	echo "Current directory:"`pwd`>>$LOGFILEPATH/custom_archive_cleanup.log


	for ((counter=0; $counter<=$RESULT_FILE_ZIPING; counter++ )){
		#Start searching result files which are created inbetween  start_t and  stop_t time
		#Subtract one day from timestamp_2d_ago
		
		zip_name=$z_time
		tmp_start=$z_time"0000"
		tmp_end=$z_time"2359"
		
		echo "Searching all files which were modiefied in bw Start time: $tmp_start and  End Time : $tmp_end  " >>$LOGFILEPATH/custom_archive_cleanup.log
		
		# Create flag files with time stamp of $start_t and $stop_t
		
		touch -t $tmp_start $ARCHIVE_DIR/start
		touch -t  $tmp_end $ARCHIVE_DIR/stop
	
		echo "Searching all files which were modiefied in bw Start time: $tmp_start and  End Time : $tmp_end ::- "   >>$LOGFILEPATH/custom_archive_cleanup.log

		find $ARCHIVE_DIR/s* -newer $ARCHIVE_DIR/start \! -newer $ARCHIVE_DIR/stop >>$LOGFILEPATH/custom_archive_cleanup.log
		echo "------end of this search--" >>$LOGFILEPATH/custom_archive_cleanup.log

				
		#Playing with above command cmd10000 WORKED
		echo "Making a tar of searched files to $zip_name.tar and also deleting  the original files " >>$LOGFILEPATH/custom_archive_cleanup.log
		#find the files and put them into tar
		find s* -newer start \! -newer stop -exec tar -C $ARCHIVE_DIR -cvf $zip_name.tar  {} \;  -exec rm -rf {} \;
		
		echo "Making a Zip of searched files to $zip_name.zip " >>$LOGFILEPATH/custom_archive_cleanup.log
		zip -r $zip_name.zip $zip_name.tar >>$LOGFILEPATH/custom_archive_cleanup.log


		echo "Deleting the original tar $zip_name.zip " >>$LOGFILEPATH/custom_archive_cleanup.log
		rm -f $zip_name.tar >>$LOGFILEPATH/custom_archive_cleanup.log


		echo "----------------------------------------------------------------------------" >>$LOGFILEPATH/custom_archive_cleanup.log
		
		z_time=$(($z_time - 1 ))
		
	}
		
	#Transfer the control to Back to Scripts folder`
	cd -
	echo "Current directory:"`pwd`>>$LOGFILEPATH/custom_archive_cleanup.log

	
#EOF

