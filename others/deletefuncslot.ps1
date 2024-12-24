# Variables
$ResourceGroupName = "rg-runbook"

# Authenticate to Azure
Connect-AzAccount

# Get all App Services in the specified App Service Plan
$appServices = Get-AzFunctionApp -ResourceGroupName "rg-runbook" | Where-Object { $_.Name -like "func-*" -and $_.Name -notlike "func-dss-001*" }

# Calculate the date 24 hours ago
$thresholdDate = (Get-Date).AddHours(-24)
 

# Loop through each App Service
foreach ($appService in $appServices) {
    # Get all slots for the App Service
    $slots = Get-AzWebAppSlot -ResourceGroupName $resourceGroupName -Name $appService.Name | Where-Object { $_.LastModifiedTimeUtc -lt $thresholdDate }
    if ($slots -eq $null) {
        Write-Output "No slots created more than 24 hours ago."
    } else {
        foreach ($slot in $slots) {
            $splitString = $slot.Name -split '/'
            $slotName = $splitString[1]
            Remove-AzWebAppSlot -ResourceGroupName $resourceGroupName -Name $appService.Name -Slot $slotName -Force
            Write-Output "Deleted slot: $($slot.Name)"
        }
    }

}



