#!/bin/bash
set -e

echo "======================================================================"
echo "🔍 Step 1: Checking prerequisites"
echo "======================================================================"

# Check if docker is installed
if ! command -v docker &> /dev/null
then
    echo "❌ Docker could not be found, please install docker."
    exit 1
else
    echo "✅ Docker is installed"
fi

# Check if kind is installed
if ! command -v kind &> /dev/null
then
    echo "❌ Kind could not be found, please install kind."
    exit 1
else
    echo "✅ Kind is installed"
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null
then
    echo "❌ Kubectl could not be found, please install kubectl."
    exit 1
else
    echo "✅ Kubectl is installed"
fi

echo
echo "======================================================================"
echo "🚀 Step 2: Creating Kubernetes cluster with Kind"
echo "======================================================================"
echo "Creating cluster with configuration from kind.yaml..."
kind create cluster --config=kind.yaml
echo "✅ Kind cluster created successfully"

echo
echo "======================================================================"
echo "🔧 Step 3: Setting up ArgoCD"
echo "======================================================================"
echo "Creating namespace for ArgoCD..."
kubectl create namespace argocd
echo "Installing ArgoCD components..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "Applying ArgoCD base configuration..."
kubectl apply -f manifests/argocd-base-cm.yaml
echo "✅ ArgoCD installation complete"

echo
echo "======================================================================"
echo "🔄 Step 4: Setting up Ingress Controller"
echo "======================================================================"
echo "Deploying NGINX ingress controller..."
kubectl apply -f manifests/deploy-ingress-nginx.yaml

echo "Waiting for ingress controller to be ready (this may take a minute)..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
echo "✅ NGINX ingress controller is ready"

echo
echo "======================================================================"
echo "🌐 Step 5: Configuring Ingress"
echo "======================================================================"
echo "Setting up ArgoCD ingress..."
kubectl apply -f manifests/deploy-argocd-ingress.yaml
echo "✅ ArgoCD ingress configured"

echo
echo "======================================================================"
echo "📦 Step 6: Deploying Sample Application"
echo "======================================================================"
echo "Deploying sample FastAPI application via ArgoCD..."
kubectl apply -f manifests/sample-app.yaml
echo "✅ Sample application deployed"

echo
echo "======================================================================"
echo "🔑 Step 7: Getting ArgoCD Credentials"
echo "======================================================================"
echo "Your ArgoCD initial admin password is:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

echo
echo "======================================================================"
echo "🎉 Setup Complete! 🎉"
echo "======================================================================"
echo "Access the sample application at: http://localhost:8000/sample"
echo "Access ArgoCD UI at: http://localhost:8000/argocd"
echo "ArgoCD username: admin"
echo "ArgoCD password: (shown above)"
echo "======================================================================"
echo
echo "📚 Next Steps for Learning GitOps:"
echo "--------------------------------------------------------------------"
echo "1. Explore the ArgoCD UI and see how it's tracking your application"
echo "2. Make a change to the application manifests"
echo "3. Watch ArgoCD automatically detect and sync the changes"
echo "4. Learn more about GitOps principles at https://www.gitops.tech/"
echo "======================================================================"
