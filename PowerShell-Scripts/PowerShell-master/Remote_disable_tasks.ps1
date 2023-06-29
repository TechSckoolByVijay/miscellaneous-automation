<#
Disabling all scheduled tasks on  multiple machines for maintenance

#>

$servers = @("SERVER_41v","SERVER_42v","SERVER_43v","SERVER_44v","SERVER_45v","SERVER_46v","SERVER_47v","SERVER_48v","SERVER_49v","SERVER_50v","SERVER_51v","SERVER_52v","SERVER_53v","SERVER_54v","SERVER_55v","SERVER_56v","SERVER_57v","SERVER_58v","SERVER_59v","SERVER_60v","SERVER_61v","SERVER_62v","SERVER_63v","SERVER_64v","SERVER_65v","SERVER_66v","SERVER_67v","SERVER_68v","SERVER_69v","SERVER_70v")


Invoke-Command -ComputerName $servers {

Get-ScheduledTask -TaskPath "\" | Disable-ScheduledTask 

}