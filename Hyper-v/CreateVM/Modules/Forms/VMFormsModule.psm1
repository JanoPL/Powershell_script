using namespace System.Windows.Forms;
using namespace System.Drawing;
using module .\..\Models\VMSettingsModel.psd1;

class VMFormsModule
{
    [System.Windows.Forms.Form] $form = (New-Object System.Windows.Forms.Form);
    
    [void] GetForm()
    {
        $this.form.Text = 'VM Settings'
        $this.form.Size = New-Object System.Drawing.Size(300,200)
        $this.form.StartPosition = 'CenterScreen'
    }

    [void] AddOKButton() 
    {
        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(75,120)
        $okButton.Size = New-Object System.Drawing.Size(75,23)
        $okButton.Text = 'OK'
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $this.form.AcceptButton = $okButton
        $this.form.Controls.Add($okButton)
    }

    [void] AddCancelButton()
    {
        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(150,120)
        $cancelButton.Size = New-Object System.Drawing.Size(75,23)
        $cancelButton.Text = 'Cancel'
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $this.form.CancelButton = $cancelButton
        $this.form.Controls.Add($cancelButton)
    }

    [void] AddTextBox([string] $name) 
    {
        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10,20)
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.Text = $name
        $this.form.Controls.Add($label)
    
        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Location = New-Object System.Drawing.Point(10,40)
        $textBox.Size = New-Object System.Drawing.Size(260,20)
        $this.form.Controls.Add($textBox)
    }

    [void] BuildForms()
    {
        $this.GetForm();

        $this.AddOKButton();
        $this.AddCancelButton();

        $this.AddTextBox("Name");

        $result = $this.form.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK)
        {
            $memoryModel = [MemoryModel]::new();
            if ($this.form.Controls.Count -gt 0) {
                # TODO implements 
            }
        }
    }

}