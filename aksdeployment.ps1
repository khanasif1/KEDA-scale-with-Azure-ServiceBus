az login

$RESOURCE_GROUP_NAME= "kedarg"
$CLUSTER_NAME="keda-servicebus-demo"
$VNET="kedaVnet"
$SUBNET="kedaSubnet"
$ACR = "msdemoregistry"
#az account list-locations -o table
$LOCATION="australiaeast"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create a virtual network and subnet
az network vnet create `
    --resource-group $RESOURCE_GROUP_NAME `
    --name  $VNET `
    --address-prefixes 10.0.0.0/8 `
    --subnet-name $SUBNET `
    --subnet-prefix 10.240.0.0/16
# Get the virtual network subnet resource ID
$SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP_NAME --vnet-name $VNET --name $SUBNET --query id -o tsv)


# AKS available version in the region
az aks get-versions --location $LOCATION --output table

# Deploy AKS
az aks create `
    --resource-group $RESOURCE_GROUP_NAME   `
    --name $CLUSTER_NAME `
    --node-count 1 `
    --generate-ssh-keys `
    --service-cidr 10.0.0.0/16 `
    --dns-service-ip 10.0.0.10 `
    --docker-bridge-address 172.17.0.1/16 `
    --vnet-subnet-id $SUBNET_ID `
    --kubernetes-version 1.21.2 `
    --network-policy azure  `
    --network-plugin azure `
    --generate-ssh-keys


# Access cluster    
az aks get-credentials --resource-group $RESOURCE_GROUP_NAME  --name $CLUSTER_NAME    

kubectl get pod -A