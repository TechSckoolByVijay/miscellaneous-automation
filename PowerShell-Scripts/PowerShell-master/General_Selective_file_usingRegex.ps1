
$file_names = Get-ChildItem -Path "C:\folder\source" -Recurse
$target_loc="C:\folder\target"


$file_names | ForEach-Object {
$file = $_
$date=""
$str = $file.BaseName
$file_name = $file.BaseName
        ##
        #Extracting date from the file name if it is yyyyMMdd format
        try {
            $date_str = [regex]::Matches($str, '(\d\d\d\d\d\d\d\d)')[0].Groups[1].Value
            $date = [datetime]::ParseExact($date_str, 'yyyyMMdd',$null)
            $file_name = $str.Replace($date_str, "")
        } catch{
           # Write-Output "Date is not in yyyyMMdd format"
        }

        ##
        #Extracting date from the file name if it is yyyy-mm-dd format

        try {
            $date_str = [regex]::Matches($str, '(\d\d\d\d-\d\d-\d\d)')[0].Groups[1].Value
            $date = [datetime]::ParseExact($date_str, 'yyyy-MM-dd',$null)
             $file_name = $str.Replace($date_str, "")
            
        } catch{
           # Write-Output "Date is not in yyyy-mm-dd format"
        }


        #If unable to get the date from filename, try to get it from file modification time
        if($date.Length -eq 0){
           # "Finding file's last modified date"
            $date = $file.LastWriteTime
                  } 
    
    
    $date_to_append = $date.ToString("yyyyMMdd")

    #replacing '-' with '_'
    $tmp1 = $file_name.replace("-", "_")
    
    #replacing ' ' with '_'
    $target_name = $tmp1.replace(" ", "_")
    
    $target_name =$target_name +"_"+ $date_to_append + $file.Extension
     $file_destination = $target_loc + "\"+ $target_name
     $file_destination
#You  have derived the name of files so far. 
#If you are will ing to retain the directory structure, then Get the directiory name
#of source file using $file.Directoryname and build 3-4 line logic to modify the desitination address
# I am leaving it up to you

  Copy-Item $file.FullName -Destination $file_destination
} 