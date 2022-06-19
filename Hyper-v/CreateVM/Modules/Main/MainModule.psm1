class MainModule 
{
    [object] $WindowsIdentity = [Security.Principal.WindowsIdentity]::GetCurrent();
    [object] $Role = [Security.Principal.WindowsBuiltinRole]::Administrator;

    [bool] isAdmin()
    {
        $windowsPrincipal = (New-Object Security.Principal.WindowsPrincipal $this.WindowsIdentity);

        If (
            $windowsPrincipal.IsInRole($this.Role) -eq $FALSE
        ) {
            Write-Host "You are NOT a local administrator. \n" -foregroundColor Red; 
            write-host "Run this script after logging on with a local administrator account.";
            return $false;
        } 

        return $true;
    }

    [void] checkHyperV()
    {
        $hyperv = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online

        if ($hyperv.State -eq 'Enabled') {
            write-host "Hyper-V is enabled" -foregroundColor Green;
            return;
        } else {
            Write-Host "Hyper-V is Disabled" -ForegroundColor Red;
            $option = Read-Host "Do you want to enable Hyper-V? yes/no";
            if ($option -eq 'yes') {

            } else {
                Write-Host "Script excexution abort, bye bye";
                return;
            }
        }
    }
}