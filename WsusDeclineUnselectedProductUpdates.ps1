Write-Host Decline Updates for Unselected Products
Write-Host

[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null

# Connect to Update Server
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()

$products = @()
$wsus.GetSubscription().GetUpdateCategories() | ? { $_.Type -eq "Product"} | ForEach-Object {
    $products += $_.Title
}

$count = 0
$wsus.GetUpdates() | ? { -not $_.IsDeclined } | ForEach-Object {
    $product_selected = $False
    ForEach ($product in $_.ProductTitles) {
        If ($products -contains $product) {
            $product_selected = $True
            break
        }
    }
    If ($product_selected) {
        # do nothing
    } Else {
        $count++
        $_.Decline($True)
        Write-Output $_.Title
    }
}
If ($count -gt 0) { Write-Host }
Write-Host Declined $count updates.