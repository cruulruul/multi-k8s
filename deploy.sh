docker build -t cruulruul/multi-client:latest -t cruulruul/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t cruulruul/multi-server:latest -t cruulruul/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t cruulruul/multi-worker:latest -t cruulruul/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push cruulruul/multi-client:latest
docker push cruulruul/multi-server:latest
docker push cruulruul/multi-worker:latest
docker push cruulruul/multi-client:$GIT_SHA
docker push cruulruul/multi-server:$GIT_SHA
docker push cruulruul/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cruulruul/multi-server:$GIT_SHA
kubectl set image deployments/server-deployment server=cruulruul/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=cruulruul/multi-server:$GIT_SHA