$LAdmin = "domain\username"
$LPassword = ConvertTo-SecureString "Password" -AsPlainText -Force
$Credentials = New-Object -Typename System.Management.Automation.PSCredential -ArgumentList $LAdmin, $LPassword

Get-WMIObject Win32_Service -Filter "Name LIKE 'IISADMIN'" -ComputerName COMP1,COMP2 -Credential $Credentials | Select * |format-table -AutoSize