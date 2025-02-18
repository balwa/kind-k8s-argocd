#!/bin/bash

# Check if docker is installed
if ! command -v docker &> /dev/null
then
    echo "docker could not be found, please install docker."
    exit 1
fi

# Check if kind is installed
if ! command -v kind &> /dev/null
then
    echo "kind could not be found, please install kind."
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null
then
    echo "kubectl could not be found, please install kubectl."
    exit 1
fi

kind create cluster --config=kind.yaml
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f manifests/deploy-ingress-nginx.yaml
kubectl apply -f manifests/argocd-base-cm.yaml

# wait for ingress to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

kubectl apply -f manifests/deploy-argocd-ingress.yaml
kubectl apply -f manifests/sample-app.yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
