# Deploy Keda
kubectl apply -f keda-2.0.0.yaml

# Delete Keda
#kubectl delete -f keda-2.0.0.yaml

kubectl config view
kubectl get pods -A