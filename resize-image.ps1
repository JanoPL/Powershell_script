### Sample showing a PowerShell GUI with drag-and-drop ###

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")


### Create form ###

$form = New-Object System.Windows.Forms.Form
$form.Text = "PS Konwerter GUI v0.1"
$form.Size = '420,320'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True



### Define controls ###

## Button

$button = New-Object System.Windows.Forms.Button
$button.Location = '5,5'
$button.Size = '75,23'
$button.Width = 120
$button.Text = "Konwertuj"

$button1 = new-object System.Windows.Forms.Button
$button1.location = '5, 30'
$button1.Size = '75,23'
$button.Width = '120'
$button1.Text = "Otwórz folder"

## OpenDialog

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Filter = "Pliki graficzne (*.jpg) | *.jpg"
$OpenFileDialog.InitialDirectory = "C:\"
$OpenFileDialog.ShowHelp = "True"


## CheckBox

$checkbox = New-Object Windows.Forms.Checkbox
$checkbox.Location = '140,8'
$checkbox.AutoSize = $True
$checkbox.Text = "Wyczyść po konwertowaniu"

## Label

$label = New-Object Windows.Forms.Label
$label.Location = '5,60'
$label.AutoSize = $True
$label.Text = "Umieść pliki tutaj:"

## ListBox

$listBox = New-Object Windows.Forms.ListBox
$listBox.Location = '5,80'
$listBox.Height = 200
$listBox.Width = 320
$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
$listBox.IntegralHeight = $False
$listBox.AllowDrop = $True

## StatusBar

$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Text = "Gotowe"


### Add controls to form ###

$form.SuspendLayout()
$form.Controls.Add($button)
$form.Controls.Add($button1)
$form.Controls.Add($checkbox)
$form.Controls.Add($label)
$form.Controls.Add($listBox)
$form.Controls.Add($statusBar)
$form.ResumeLayout()


### Write event handlers ###

$button_Click1 = {



}


$button_Click = {
    write-host "pliki do konwertowania:" -ForegroundColor Yellow

	foreach ($item in $listBox.Items)
    {
        $i = Get-Item -LiteralPath $item
        if($i -is [System.IO.DirectoryInfo])
        {
            write-host ("`t" + $i.Name + " [Directory]")
        }
        else
        {
            write-host ("`t" + $i.Name + " [" + [math]::round($i.Length/1MB, 2) + " MB]")
            $item = ls *.jpg


        }
	}

    if($checkbox.Checked -eq $True)
    {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("Lista zawiera $($listBox.Items.Count) plików")

foreach ($item in  $listBox.Items) {
    
    if (test-path out){
    write-host ("Konwertuje" + "`t" + $item.Name)
    } else {
    Write-Host "Kreacja folderu out" 
    mkdir out
    }

    convert.exe $item -verbose -resize 112x96 -loop 0 -set filename:f '%t' out/'%[filename:f].gif'

}
    write-host "Koniec konwertowania"
    write-host "Otworzenie folderu out"
    start out
}

$listBox_DragOver = [System.Windows.Forms.DragEventHandler]{
	if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) # $_ = [System.Windows.Forms.DragEventArgs]
	{
	    $_.Effect = 'Copy'
	}
	else
	{
	    $_.Effect = 'None'
	}
}
	
$listBox_DragDrop = [System.Windows.Forms.DragEventHandler]{
	foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) # $_ = [System.Windows.Forms.DragEventArgs]
    {
		$listBox.Items.Add($filename)
	}
    $statusBar.Text = ("Lista zawiera $($listBox.Items.Count) plików")
}

$form_FormClosed = {
	try
    {
        $listBox.remove_Click($button_Click)
        $listbox.remove_Click($button_Click1)
		$listBox.remove_DragOver($listBox_DragOver)
		$listBox.remove_DragDrop($listBox_DragDrop)
        $listBox.remove_DragDrop($listBox_DragDrop)
		$form.remove_FormClosed($Form_Cleanup_FormClosed)
	}
	catch [Exception]
    { }
}


### Wire up events ###

$button.Add_Click($button_Click)
$button1.Add_Click($button_Click1)
$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)
$form.Add_FormClosed($form_FormClosed)


#### Show form ###

[void] $form.ShowDialog()