# Get the list of resources and store them in a variable.
$resources = Get-AzResource -ResourceGroupName rg-my-old-resourcegroup
# Display the ResoureID values on the screen.
 $resources.ResourceId

 Move the resources to the destination resource group rg-my-new-resourcegroup
 Move-AzResource -DestinationResourceGroupName rg-my-new-resourcegroup -ResourceId $resources.ResourceId

# Gets a list of resources in the source resource group
 Get-AzResource -ResourceGroupName rg-my-old-resourcegroup
# Gets a list of resources in the destination resource group
 Get-AzResource -ResourceGroupName rg-my-new-resourcegroup
