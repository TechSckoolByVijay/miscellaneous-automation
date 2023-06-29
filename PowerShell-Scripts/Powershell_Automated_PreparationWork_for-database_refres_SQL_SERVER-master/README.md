# POwershell_Automated_PreparationWork_for-database_refres_SQL_SERVER


Introduction

DB Refresh Prep work is an activity performed by Application team before the start of activity.

This is to ensure that the DB refresh can be performed without facing any difficulty. If there is any issues, it can be fixed well before the activity.

Prep work covers
	Connectivity to the target database server and database
	Backup is copied/available to the target server
	There is adequate space available on the target server to perform the activity.


This automation aims to do this manual task in much simpler and highly accurate way.


Software/Tools Required:

o	Powershell 4.0 or higher
o	SQLCMD on local machine
o	ODBC SQL server drivers


Steps to perform the activity


0.)	Before starting with the activity, you need
	-*Source/Target DB details(ie. server name * oltp db name and username, password)
	-Target DB server RDP access.(not mandatory. Required for disk space analysis.)

1.)	Once all the perquisites softwares are installed, run the prep_work.ps1 script. 

2.)	Fill the source & Target DB details 

3.)	Click the “Get Disk Space” button to get the free space available on the target DB server. Enter the username and password in the popup. If you have rdp access to the server, you will get the details added in view as below.
4.)	Once filled all details, Click Export Pre Work, and wait till you see the below message


------------------------------------ 
You will see the all required details in the html file. Csv file is just for the reference and all details are compiled into html file available in the output folder.

------------------------------------ 


Feel free to use it as per you requirement. Please contact me at VijaySainiProfessional@gmail.com to understand it in more details

