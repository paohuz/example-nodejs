#!/bin/bash

# Set ENV
DOCKER_USER=pornpasok
DEV_PROJECT=development
APP_TAG=latest
NODE_ENV=development
port=6379
host=redis

# Build Docker Image
docker image build -t ${DOCKER_USER}/hello1 ./docker/hello1/
docker image build -t ${DOCKER_USER}/hello2 ./docker/hello2/
docker image build -t ${DOCKER_USER}/nginx-lb ./docker/nginx/

# Push Docker Image to Docker Hub
docker push ${DOCKER_USER}/hello1
docker push ${DOCKER_USER}/hello2
docker push ${DOCKER_USER}/nginx-lb

# Deploy to Dev ENV

# Redis
kubectl create deployment redis -n ${DEV_PROJECT} --image=redis:alpine &&
kubectl expose deployment redis -n ${DEV_PROJECT} --port=6379 --target-port=6379 

# Hello1 App
kubectl create deployment hello1 -n ${DEV_PROJECT} --image=${DOCKER_USER}/hello1:${APP_TAG} &&
kubectl expose deployment hello1 -n ${DEV_PROJECT} --port=8000 --target-port=8000 
kubectl set env deployment/hello1 NODE_ENV=${NODE_ENV} port=${port} host=${host}

# Hello2 App
kubectl create deployment hello2 -n ${DEV_PROJECT} --image=${DOCKER_USER}/hello2:${APP_TAG} &&
kubectl expose deployment hello2 -n ${DEV_PROJECT} --port=8000 --target-port=8000 
kubectl set env deployment/hello1 NODE_ENV=${NODE_ENV} port=${port} host=${host}

# nginx-lb
kubectl create deployment lb -n ${DEV_PROJECT} --image=${DOCKER_USER}/nginx-lb:${APP_TAG} &&
kubectl expose deployment lb -n ${DEV_PROJECT} --port=80 --target-port=80

# Scale App
kubectl scale deployment hello1 -n ${DEV_PROJECT} --replicas=2
kubectl scale deployment hello2 -n ${DEV_PROJECT} --replicas=2

# Check App
sleep 30

# Hello1 App
STATUSCODE=$(curl -s -o /dev/null -I -w "%{http_code}" http://lb/hello1)
if test $STATUSCODE -ne 200; then echo ERROR:$STATUSCODE && exit 1; else echo SUCCESS; fi;

# Hello2 App
STATUSCODE=$(curl -s -o /dev/null -I -w "%{http_code}" http://lb/hello2)
if test $STATUSCODE -ne 200; then echo ERROR:$STATUSCODE && exit 1; else echo SUCCESS; fi;
