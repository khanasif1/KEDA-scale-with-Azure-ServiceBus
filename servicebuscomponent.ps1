$RESOURCE_GROUP_NAME= "kedarg"
$SERVICE_BUS_NAME= "kedasb"


az servicebus namespace create --name $SERVICE_BUS_NAME --resource-group $RESOURCE_GROUP_NAME --sku basic


az servicebus queue create --namespace-name  $SERVICE_BUS_NAME --name orders --resource-group  $RESOURCE_GROUP_NAME

az servicebus queue authorization-rule create --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name order-consumer --rights Listen

#Connection string for app - Listener 
az servicebus queue authorization-rule keys list --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name order-consumer

# Run on Linux shell 
echo "Endpoint=sb://kedasb.servicebus.windows.net/;SharedAccessKeyName=order-consumer;SharedAccessKey=******;EntityPath=orders" | base64

echo "****" | base64 --decode


#Management permissions so that KEDA can monitor
az servicebus queue authorization-rule create --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name keda-monitor --rights Manage Send Listen

# Connection string for KEDA monitor

az servicebus queue authorization-rule keys list --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name keda-monitor

echo "Endpoint=sb://kedasb.servicebus.windows.net/;SharedAccessKeyName=keda-monitor;SharedAccessKey=WKqrhQhaDv0BvIQ0ihBWx1VjdcIrcygS6US+6VaFQOQ=;EntityPath=orders" | base64

echo "RW5kcG9pbnQ9c2I6Ly9rZWRhc2Iuc2VydmljZWJ1cy53aW5kb3dzLm5ldC87U2hhcmVkQWNjZXNzS2V5TmFtZT1rZWRhLW1vbml0b3I7U2hhcmVkQWNjZXNzS2V5PVdLcXJoUWhhRHYwQnZJUTBpaEJXeDFWamRjSXJjeWdTNlVTKzZWYUZRT1E9O0VudGl0eVBhdGg9b3JkZXJzCg==" | base64 --decode
