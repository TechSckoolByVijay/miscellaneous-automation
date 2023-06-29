$original_text = @(gc .\original.txt) #


#Adding extra \ to escape
$original = "YMCAGH\\PROD"
$replace_by = "Vivek\test"


#If you want, you can delete the original file and name the few file same as original name
$original_text | % {$_ -replace "$original", "$replace_by" } | Write-Output | Set-Content newFile.txt
