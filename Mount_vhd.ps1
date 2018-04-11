clear-host 

## ścieżka do folderu
$dir = "C:\VHD"


## Test ścieżki do folderu
if (!(Test-Path $dir)) {

    New-Item -Path $dir -ItemType Directory 
} else {
echo "Ścieżka istnieje" 
}

## Montowanie dysku VHD

if ((Get-DiskImage -ImagePath C:\dysk_vhd.vhd)) {
    Mount-DiskImage -ImagePath C:\dysk_vhd.vhd -StorageType VHD -Access ReadWrite -Verbose 
    echo "Dysk zamontowany"
} else { echo "Dysk już jest zamontowany"}

## Punkt montowania + dodanie do VHD

## Wyszukiwanie dysku wirtualnego 
$disk = get-disk -Path "\\?\scsi#disk&ven_msft&prod*" 

 #(Get-Partition -DiskNumber $disk).AccessPaths -- do usunięcia

 $Partition = Get-Partition -DiskNumber $disk.Number
 $Partition | Add-PartitionAccessPath -AccessPath $dir


## Uruchomienie folderu podmontowanego
start $dir
