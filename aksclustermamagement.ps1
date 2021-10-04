<#
https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster
#>

$RESOURCE_GROUP_NAME= "kedarg"
$CLUSTER_NAME="keda-servicebus-demo"


# Install the aks-preview extension
az extension add --name aks-preview

# Update the extension to make sure you have the latest version installed
az extension update --name aks-preview

#Register preview in subscription
az feature register --namespace "Microsoft.ContainerService" --name "StartStopPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/StartStopPreview')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.ContainerService

#Stop an AKS Cluster
az aks stop --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP_NAME

#Start an AKS Cluster
az aks start --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP_NAME