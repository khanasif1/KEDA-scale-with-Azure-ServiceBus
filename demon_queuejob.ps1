git clone https://github.com/kedacore/sample-dotnet-worker-servicebus-queue

cd sample-dotnet-worker-servicebus-queue


dotnet run --project .\src\Keda.Samples.Dotnet.OrderGenerator\Keda.Samples.Dotnet.OrderGenerator.csproj


kubectl get pods --namespace keda-dotnet-sample

kubectl logs order-processor-dc5b446dd-8hf5g --namespace keda-dotnet-sample