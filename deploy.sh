docker build -t scarron95/multi-client:latest -t scarron95/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t scarron95/multi-server:latest -t scarron95/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t scarron95/multi-worker:latest -t scarron95/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push scarron95/multi-client:latest
docker push scarron95/multi-server:latest
docker push scarron95/multi-worker:latest

docker push scarron95/multi-client:$SHA
docker push scarron95/multi-server:$SHA
docker push scarron95/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=scarron95/multi-server:$SHA
kubectl set image deployments/client-deployment client=scarron95/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=scarron95/multi-worker:$SHA