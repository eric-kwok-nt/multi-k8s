docker build -t xholyspirit/multi-client-k8s:latest -t xholyspirit/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t xholyspirit/multi-server-k8s-pgfix:latest -t xholyspirit/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t xholyspirit/multi-worker-k8s:latest -t xholyspirit/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push xholyspirit/multi-client-k8s:latest
docker push xholyspirit/multi-server-k8s-pgfix:latest
docker push xholyspirit/multi-worker-k8s:latest

# The push command does not push all the tags that the image has, it requires user to manually push all of them.
docker push xholyspirit/multi-client-k8s:$SHA
docker push xholyspirit/multi-server-k8s-pgfix:$SHA
docker push xholyspirit/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xholyspirit/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=xholyspirit/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=xholyspirit/multi-worker-k8s:$SHA