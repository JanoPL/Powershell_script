# Config

## VHD Disk name
$diskName = "disk_vhd.vhd";
## Path to directory
$directory = "C:\VHD" 

function checkPath {
    if (!(Test-Path $directory)) {
        createDirectory($directory);
    } else {
        Write-Host "Path Exist, Directory not created: $directory " 
    }    
}
function createDirectory ($directory) {
    New-Item -Path $directory -ItemType Directory;
}

## Mounting vhd disk
function MountVHD($diskName) {
    if ((Get-DiskImage -ImagePath C:\$diskName)) {
        Mount-DiskImage -ImagePath C:\$diskName -StorageType VHD -Access ReadWrite -Verbose;
        Write-Host "Disk has been mounted";
    } else {
        Write-Host "Disk already mounted";
    }
}

## Searching VHD disk
function getVhdDisk {
    $disk = get-disk -Path "\\?\scsi#disk&ven_msft&prod*" 
    $Partition = Get-Partition -DiskNumber $disk.Number
    $Partition | Add-PartitionAccessPath -AccessPath $directory
}

## Starting mounted dir
function openDirectory($directory) {
    Start-Process $directory;    
}

checkPath;
MountVHD;
getVhdDisk;

Write-Host "Do you want open created Directory? (Y/N)";
$wantOpen = Read-Host

if ($wantOpen -eq ("Y" || "y")) {
    openDirectory($directory);
}
