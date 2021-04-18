#!/bin/bash

kubectl create -f ./kubernetes/spark-master-deployment.yaml
kubectl create -f ./kubernetes/spark-worker-deployment.yaml