# Deploy Keda
kubectl apply -f ./yaml/keda-2.0.0.yaml

# Delete Keda
#kubectl delete -f keda-2.0.0.yaml

kubectl config view
kubectl get pods -A
kubectl get ns

#******************************
#******DEPLOY SAMPLE APP*******
#******************************

kubectl create namespace keda-dotnet-sample

# Deploy Secret for app
kubectl apply -f .\yaml\deploy-app.yaml --namespace keda-dotnet-sample

#Check Secret
kubectl get secrets --namespace keda-dotnet-sample

kubectl get deployments --namespace keda-dotnet-sample -o wide

# Deploy secret for autoscale
kubectl apply -f .\yaml\deploy-autoscaling.yaml --namespace keda-dotnet-sample



