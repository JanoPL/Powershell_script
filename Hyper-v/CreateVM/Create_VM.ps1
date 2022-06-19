using module .\Modules\Main\MainModule.psd1;
using module .\Modules\Forms\VMFormsModule.psd1;

$mainModule = [MainModule]::new();

if ($mainModule.isAdmin() -eq $true -and $mainModule.checkHyperV() -eq $true) {
    $forms = [VMFormsModule]::new();
    $forms.BuildForms();
}

exit;