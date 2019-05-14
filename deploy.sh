docker build -t aloroc/multi-client:latest -t aloroc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aloroc/multi-server:latest -t aloroc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aloroc/multi-worker:latest -t aloroc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aloroc/multi-client:latest
docker push aloroc/multi-server:latest
docker push aloroc/multi-worker:latest


docker push aloroc/multi-client:$SHA
docker push aloroc/multi-server:$SHA
docker push aloroc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aloroc/multi-server:$SHA
kubectl set image deployments/client-deployment client=aloroc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aloroc/multi-worker:$SHA
