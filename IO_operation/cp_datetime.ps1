param ($param1);
Write-Host $param1;

if ($args[0] -eq '-h') {
    Write-Host("
        Copy file to specific path and auto add datetime to name\n
        
        example:
        cp_datetime.ps1 <file_name> <destination_path>
        cp_datetime.ps1 C:\test.file C:\test_dir
        
    ");
} elseif ($null -eq $args[0]) {
    Write-Error('No name parameters, please add file name to copy');
} elseif ($null -eq $args[1]) {
    Write-Error('No path parameters, please add file name to copy');
}

[string] $name = $args[0];
[string] $path = $args[1];
$now = [datetime]::Now.ToString('dd_mm_yyyy');

xcopy.exe /W /Y $name "$($path)/$($name)_$($now)"