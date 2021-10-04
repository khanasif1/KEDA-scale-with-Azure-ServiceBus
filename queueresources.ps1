
$RESOURCE_GROUP_NAME= "kedarg"
$SERVICE_BUS_NAME= "kedasb"


az servicebus namespace create --name $SERVICE_BUS_NAME --resource-group $RESOURCE_GROUP_NAME --sku basic


az servicebus queue create --namespace-name  $SERVICE_BUS_NAME --name orders --resource-group  $RESOURCE_GROUP_NAME

az servicebus queue authorization-rule create --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name order-consumer --rights Listen

az servicebus queue authorization-rule keys list --resource-group $RESOURCE_GROUP_NAME --namespace-name $SERVICE_BUS_NAME --queue-name orders --name order-consumer

echo -n "Endpoint=sb://kedasb.servicebus.windows.net/;SharedAccessKeyName=order-consumer;SharedAccessKey=sy+8Q3UuQGpi5Zo/LxMlyu1IPzZ1kKEbhP1aHmGDKkM=;EntityPath=orders" | base64

