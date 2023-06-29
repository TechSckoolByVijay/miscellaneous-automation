

#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="WpfApplication.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication1"
        mc:Ignorable="d"
        Title="DB Refresh Prep Work" Height="868.999" Width="1564" WindowStartupLocation="CenterOwner">
    <Window.Background>
        <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
            <GradientStop Color="#FFAAB992" Offset="0.292"/>
            <GradientStop Color="#FFC5CEF0" Offset="0.778"/>
        </LinearGradientBrush>
    </Window.Background>
    <Grid HorizontalAlignment="Left" Height="291" Margin="45,73,0,0" VerticalAlignment="Top" Width="720">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="0*"/>
            <ColumnDefinition Width="0*"/>
            <ColumnDefinition Width="28*"/>
            <ColumnDefinition Width="139*"/>
            <ColumnDefinition Width="137*"/>
            <ColumnDefinition Width="173*"/>
            <ColumnDefinition Width="76*"/>
            <ColumnDefinition Width="93*"/>
            <ColumnDefinition Width="0*"/>
        </Grid.ColumnDefinitions>
        <Label x:Name="Source_Server_lablel" Content="Source Details" Margin="0,-51,36,0" VerticalAlignment="Top" FontStretch="SemiCondensed" FontWeight="Bold" Height="31" Width="111" Background="#FFC9C2BF" FontStyle="Italic" HorizontalAlignment="Right" Grid.Column="3" FontSize="14">
            <Label.BindingGroup>
                <BindingGroup/>
            </Label.BindingGroup>
        </Label>

        <Label x:Name="Source_Server_Name" Content="Source Server (eg. Prod)" HorizontalAlignment="Center" Margin="7.836,10,15.646,0" VerticalAlignment="Top" Height="34" Width="284" Grid.ColumnSpan="2" Grid.Column="3"/>
        <TextBox x:Name="source_server" HorizontalAlignment="Right" Height="36" Margin="0,5,42.902,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="292" SelectionBrush="#FF466F99" Grid.ColumnSpan="2" Grid.Column="4" Background="#FFE8E8E8" Foreground="#FFCF1D1D" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="oltp_db" Content="OLTP Database" HorizontalAlignment="Left" Margin="25,60,0,0" VerticalAlignment="Top" AutomationProperties.Name="OLTP DB" Height="34" Width="147" Grid.Column="3" FontStyle="Italic" Grid.ColumnSpan="2"/>
        <TextBox x:Name="source_oltp" HorizontalAlignment="Left" Height="25" Margin="10.128,60,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="194" Grid.Column="4" Background="#FFE8E8E8" Grid.ColumnSpan="2" Foreground="#FFCF1D1D" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="source_wh" HorizontalAlignment="Left" Height="21" Margin="31,125,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="117" Grid.Column="2" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" Grid.ColumnSpan="2"/>
        <TextBox x:Name="source_archive" HorizontalAlignment="Left" Height="21" Margin="137.836,125,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="151" Foreground="#FFCF1D1D" Background="#FFE8E8E8" Grid.Column="3" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" Grid.ColumnSpan="2"/>
        <TextBox x:Name="source_pos" HorizontalAlignment="Left" Height="24" Margin="10.647,122,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="152" Grid.Column="5" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="label" Content="Archive" HorizontalAlignment="Left" Margin="6,95,0,0" VerticalAlignment="Top" Height="30" Width="70" Grid.Column="4" FontStyle="Italic"/>
        <Label x:Name="label1" Content="WH" HorizontalAlignment="Left" Margin="25,95,0,0" VerticalAlignment="Top" Height="30" Width="40" Grid.Column="3" FontStyle="Italic"/>
        <Label x:Name="label2" Content="POS" HorizontalAlignment="Left" Margin="48,95,0,0" VerticalAlignment="Top" Height="30" Width="44" Grid.Column="5" FontStyle="Italic"/>
        <TextBox x:Name="source_other" HorizontalAlignment="Left" Height="21" Margin="184.647,125,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="147" Grid.Column="5" Grid.ColumnSpan="3" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="label2_Copy" Content="Other(Optional)" HorizontalAlignment="Left" Margin="0,95,0,0" VerticalAlignment="Top" Height="30" Width="137" Grid.Column="6" FontStyle="Italic" Grid.ColumnSpan="2"/>
        <TextBox x:Name="source_db_user" Grid.Column="3" Height="21" Margin="134.836,162,0,0" TextWrapping="Wrap" Text="deploy" VerticalAlignment="Top" Width="154" Background="#FFECE7E7" HorizontalAlignment="Left" TextAlignment="Center" Grid.ColumnSpan="2" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="source_db_pass" Grid.Column="3" HorizontalAlignment="Left" Height="24" Margin="137.836,198,0,0" TextWrapping="Wrap" Text="deploy#1" VerticalAlignment="Top" Width="150" Background="#FFECE7E7" TextAlignment="Center" Grid.ColumnSpan="2" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="Source_Server_Copy1" Content="Target Details" HorizontalAlignment="Left" Margin="79,-51,-202,0" VerticalAlignment="Top" FontStretch="SemiCondensed" FontWeight="Bold" Height="34" Width="123" Background="#FFC9C2BF" FontStyle="Italic" Grid.Column="8" FontSize="14">
            <Label.BindingGroup>
                <BindingGroup/>
            </Label.BindingGroup>
        </Label>

        <Label x:Name="Source_Server_Name_Copy1" Content="Target Server (eg. Test)" HorizontalAlignment="Left" Margin="56,10,-218,0" VerticalAlignment="Top" Height="36" Width="162" Grid.Column="8"/>
        <TextBox x:Name="target_server" HorizontalAlignment="Left" Height="36" Margin="222.588,5,-521.588,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="299" SelectionBrush="#FF466F99" Grid.Column="8" Background="#FFE8E8E8" Foreground="#FFCF1D1D" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="oltp_db_Copy" Content="OLTP Database" HorizontalAlignment="Left" Margin="72,60,-223,0" VerticalAlignment="Top" AutomationProperties.Name="OLTP DB" Height="29" Width="151" Grid.Column="8" FontStyle="Italic"/>
        <TextBox x:Name="target_oltp" HorizontalAlignment="Left" Height="29" Margin="223,60,-422,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="199" Grid.Column="8" Background="#FFE8E8E8" Foreground="#FFCF1D1D" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="target_wh" HorizontalAlignment="Left" Height="24" Margin="55.588,122,-195.588,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="140" Grid.Column="8" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="target_archive" HorizontalAlignment="Left" Height="24" Margin="211.588,122,-359.588,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="148" Foreground="#FFCF1D1D" Background="#FFE8E8E8" Grid.Column="8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="target_pos" HorizontalAlignment="Left" Height="24" Margin="385.588,122,-540.588,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="155" Grid.Column="8" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="label_Copy" Content="Archive" HorizontalAlignment="Left" Margin="247.588,95,-319.588,0" VerticalAlignment="Top" Height="27" Width="72" Grid.Column="8" FontStyle="Italic"/>
        <Label x:Name="label1_Copy" Content="WH" HorizontalAlignment="Left" Margin="77.588,95,-118.588,0" VerticalAlignment="Top" Height="23" Width="41" Grid.Column="8" FontStyle="Italic"/>
        <Label x:Name="label2_Copy1" Content="POS" HorizontalAlignment="Left" Margin="423.588,95,-468.588,0" VerticalAlignment="Top" Height="27" Width="45" Grid.Column="8" FontStyle="Italic"/>
        <TextBox x:Name="target_other" HorizontalAlignment="Left" Height="24" Margin="565.588,122,-716.588,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="151" Grid.Column="8" Foreground="#FFCF1D1D" Background="#FFE8E8E8" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="label2_Copy2" Content="Other(Optional)" HorizontalAlignment="Left" Margin="565.588,95,-697.588,0" VerticalAlignment="Top" Height="27" Width="132" Grid.Column="8" FontStyle="Italic"/>
        <TextBox x:Name="target_db_user" Grid.Column="8" Height="23" Margin="203.588,160,-361.588,0" TextWrapping="Wrap" Text="deploy" VerticalAlignment="Top" Width="158" Background="#FFECE7E7" HorizontalAlignment="Left" TextAlignment="Center" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="target_db_pass" Grid.Column="8" HorizontalAlignment="Left" Height="24" Margin="203.588,198,-357.588,0" TextWrapping="Wrap" Text="deploy#1" VerticalAlignment="Top" Width="154" Background="#FFECE7E7" TextAlignment="Center" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Button x:Name="export_DB_Details" Content="Export Prep Work" HorizontalAlignment="Left" Height="40" Margin="235.588,575,-361.588,-334" VerticalAlignment="Top" Width="126" Grid.Column="8" RenderTransformOrigin="0.407,-0.75" BorderBrush="#FFB48080" Foreground="#FF5F7260" FontSize="14">
            <Button.Background>
                <LinearGradientBrush EndPoint="0,1" StartPoint="0,0">
                    <GradientStop Color="#FFF3F3F3" Offset="0"/>
                    <GradientStop Color="#FFEBEBEB" Offset="0.5"/>
                    <GradientStop Color="#FFDDDDDD" Offset="0.5"/>
                    <GradientStop Color="#FF6A82AC" Offset="1"/>
                </LinearGradientBrush>
            </Button.Background>
        </Button>
        <Label x:Name="label_Copy1" Content="DB User" HorizontalAlignment="Left" Margin="9.836,165,0,0" VerticalAlignment="Top" Height="28" Width="79" Grid.Column="3" FontStyle="Italic"/>
        <Label x:Name="label_Copy2" Content="DB Password" HorizontalAlignment="Left" Margin="9.836,198,0,0" VerticalAlignment="Top" Height="32" Width="101" Grid.Column="3" FontStyle="Italic"/>
        <Label x:Name="Source_Server_Copy2" Content="DB Password" HorizontalAlignment="Left" Margin="78.588,198,-181.588,0" VerticalAlignment="Top" FontStretch="SemiCondensed" Height="24" Width="103" Background="#00000000" FontStyle="Italic" Grid.Column="8">
            <Label.BindingGroup>
                <BindingGroup/>
            </Label.BindingGroup>
        </Label>
        <Label x:Name="Source_Server_Copy" Content="DB User" HorizontalAlignment="Left" Margin="78.588,163,-156.588,0" VerticalAlignment="Top" FontStretch="SemiCondensed" Height="30" Width="78" Background="#00000000" FontStyle="Italic" Grid.Column="8">
            <Label.BindingGroup>
                <BindingGroup/>
            </Label.BindingGroup>
        </Label>
        <Border BorderBrush="#FF611111" BorderThickness="2" HorizontalAlignment="Left" Height="252" Margin="0,-12,-13.523,0" VerticalAlignment="Top" Width="734" Grid.Column="2" Grid.ColumnSpan="7" RenderTransformOrigin="0.5,0.5"/>
        <Border BorderBrush="#FF611111" BorderThickness="2" HorizontalAlignment="Left" Margin="34.523,-12,-770.523,51" Width="736" Grid.Column="8"/>
        <TextBox x:Name="source_server_for_disk_analysis" Grid.Column="2" HorizontalAlignment="Left" Height="22" Margin="17,298,0,-29" TextWrapping="Wrap"  VerticalAlignment="Top" Width="245" Background="#FFECE7E7" TextAlignment="Center" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" Grid.ColumnSpan="3"/>
        <Button x:Name="get_disk_space" Content="Get Disk Space" Grid.Column="4" HorizontalAlignment="Left" Height="22" Margin="89.128,298,0,-39" VerticalAlignment="Top" Width="105" BorderBrush="#FF834545" Foreground="#FF936161" Grid.ColumnSpan="2">
            <Button.Background>
                <LinearGradientBrush EndPoint="0,1" StartPoint="0,0">
                    <GradientStop Color="#FFF3F3F3" Offset="0"/>
                    <GradientStop Color="#FFEBEBEB" Offset="0.5"/>
                    <GradientStop Color="#FFDDDDDD" Offset="0.5"/>
                    <GradientStop Color="#FF666E69" Offset="1"/>
                </LinearGradientBrush>
            </Button.Background>
        </Button>
        <Border BorderBrush="#FF291414" BorderThickness="2" Grid.Column="2" HorizontalAlignment="Left" Height="480" Margin="0,270,-769.523,-459" VerticalAlignment="Top" Width="1490" Grid.ColumnSpan="7"/>
        <TextBox x:Name="case_number" Grid.Column="8" HorizontalAlignment="Left" Height="20" Margin="195.588,319,-345.588,-58" TextWrapping="Wrap"  VerticalAlignment="Top" Width="150" Background="#FFECE7E7" TextAlignment="Center" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label x:Name="label4" Content="Case Number" Grid.Column="8" Height="32" Margin="78.588,319,-175.588,-70" Width="97" FontStyle="Italic" RenderTransformOrigin="0.551,1.382" VerticalAlignment="Top" HorizontalAlignment="Center"/>
        <Label x:Name="label4_Copy" Content="Type of Activity" Grid.Column="8" Height="32" Margin="78.588,351,-175.588,-102" Width="97" FontStyle="Italic" RenderTransformOrigin="0.551,1.382" VerticalAlignment="Top" HorizontalAlignment="Center"/>
        <ComboBox x:Name="activity_type" Grid.Column="8" HorizontalAlignment="Left" Height="23" Margin="195.588,353,-345.588,-95" VerticalAlignment="Top" Width="150">
            <ComboBoxItem IsSelected="True">DB Refresh</ComboBoxItem>
            <ComboBoxItem>DB Refresh and Upgrade</ComboBoxItem>
        </ComboBox>
        <DatePicker x:Name="scheduled_date"  Grid.Column="8" HorizontalAlignment="Left" Height="25" Margin="195.588,386,-337.588,-130" VerticalAlignment="Top" Width="142"/>
        <Label x:Name="label4_Copy1" Content="Scheduled on" Grid.Column="8" Height="26" Margin="78.588,385,-190.588,-130" Width="112" FontStyle="Italic" RenderTransformOrigin="0.551,1.382" VerticalAlignment="Top" HorizontalAlignment="Center"/>
        <ListView x:Name="listView" HorizontalAlignment="Left" Height="400" Margin="15,335,-13.523,-444" VerticalAlignment="Top" Width="719" Grid.ColumnSpan="9" BorderBrush="#FFD8DDE8" Background="#FF959384">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="Drive" Width="50" DisplayMemberBinding="{Binding drive}" />
                    <GridViewColumn Header="Volume Label" Width="150" DisplayMemberBinding="{Binding volume_label}" />
                    <GridViewColumn Header="Drive Size(GB)" Width="150" DisplayMemberBinding="{Binding drive_size}" />
                    <GridViewColumn Header="Free Space(MB)" Width="150" DisplayMemberBinding="{Binding free_space_mb}" />
                    <GridViewColumn Header="Free Space(GB)" Width="100" DisplayMemberBinding="{Binding free_space_gb}" />
                    <GridViewColumn Header="% Free Space" Width="100" DisplayMemberBinding="{Binding free_space_percent}" />
                </GridView>
            </ListView.View>
            <ListView.GroupStyle>
                <GroupStyle>
                    <GroupStyle.HeaderTemplate>
                        <DataTemplate>
                            <TextBlock FontWeight="Bold" FontSize="14" Text="{Binding Name}"/>
                        </DataTemplate>
                    </GroupStyle.HeaderTemplate>
                </GroupStyle>
            </ListView.GroupStyle>
        </ListView>
    </Grid>


</Window>
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
 
#$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "var_$($_.Name)" -Value $Form.FindName($_.Name) -Scope Global  }
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "var_$($_.Name)" -Value $Form.FindName($_.Name) }
 

#--------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------


Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable var_*
}



#--------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------



$var_export_DB_Details.Add_Click({

try{

#Calling function to populate data into csv and 
#Instantiate source and target arraylist variables
 Export_DB_Details_to_CSV
 	
#Preparing the html report by calling the required function
prepare_html_report


$wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("Operation Completed. Please check prep work in output folder",0,"Done",0x1)


} catch{
		$ErrorMessage = $_.Exception.Message
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Fatal Error: $nl Message: $ErrorMessage",0,"OK",0x1)
}

})


$var_source_oltp.Add_TextChanged({
$oltp=$var_source_oltp.Text;
$tmp="$oltp _wh";
$tmp = $tmp -replace '\s',''
$var_source_wh.Text=$tmp

$tmp="$oltp _archive";
$tmp = $tmp -replace '\s',''
$var_source_archive.Text=$tmp

$tmp="$oltp _pos";
$tmp = $tmp -replace '\s',''
$var_source_pos.Text=$tmp

})


$var_target_oltp.Add_TextChanged({

$oltp=$var_target_oltp.Text;
$tmp="$oltp _wh";
$tmp = $tmp -replace '\s',''
$var_target_wh.Text=$tmp

$tmp="$oltp _archive";
$tmp = $tmp -replace '\s',''
$var_target_archive.Text=$tmp

$tmp="$oltp _pos";
$tmp = $tmp -replace '\s',''
$var_target_pos.Text=$tmp

})

$var_target_server.Add_TextChanged({
	$var_source_server_for_disk_analysis.Text=$var_target_server.Text;
})

$var_get_disk_space.Add_Click({

	Get-DiskInfo
})


#------------------------------------------------------------------------
#------------------------------------------------------------------------
#------------------------------------------------------------------------

$Form.ShowDialog() | out-null


