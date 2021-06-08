function isLogin($azurSubscriptionId) {
    $azureContext = Get-AzContext;

    if (!$azureContext -or ($azureContext.Subscription.Id -ne $azurSubscriptionId)){
        if ($azurSubscriptionId) {
            Connect-AzAccount -Subscription $azurSubscriptionId;
        } else {
            $connect = Connect-AzAccount;
            if ($connect) {
                Write-Host "Logged to Azure Account";
                return $true;
            }
        }
    } else {
        if ($azurSubscriptionId) {
            Write-Host "SubscriptionId: $azurSubscriptionId already connected";
        } else {
            Write-Host "Already connected";
        }
        return $true;
    }

    return $false;
}

isLogin;
