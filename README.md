# 🚢 GitOps Demo with Kind, Kubernetes, and ArgoCD

This project is a comprehensive hands-on learning environment for understanding GitOps principles using Kind, Kubernetes, and ArgoCD. It deploys a sample FastAPI application using the GitOps approach for continuous deployment.

![Architecture Diagram](https://via.placeholder.com/800x400?text=GitOps+Demo+Architecture)

## 🎯 Learning Objectives

- Understand the GitOps workflow for deploying applications to Kubernetes
- Learn how ArgoCD implements continuous deployment from Git repositories
- Explore Kubernetes concepts like Deployments, Services, Ingress, and ConfigMaps
- See how NGINX Ingress Controller routes traffic to applications

## 📋 Prerequisites

- Docker
- kind (Kubernetes in Docker)
- kubectl (Kubernetes command-line tool)

## 🔍 Project Structure

### 🛠️ Setup & Configuration

- **setup.sh**: Interactive setup script with clear step-by-step progress indicators
- **cleanup.sh**: Script to cleanly delete the Kubernetes cluster
- **Makefile**: Simplifies setup and cleanup tasks
- **kind.yaml**: Configuration file for the Kind cluster with port mappings

### 📱 Sample Application

- **app/sample/main.py**: Simple FastAPI application with endpoints:
  - `/`: Returns a greeting message with hostname
  - `/ping`: Basic endpoint returning "pong"
  - `/health`: Health check endpoint
- **app/sample/Dockerfile**: Container image definition for the app
- **app/sample/requirements.txt**: Python dependencies

### 📄 Kubernetes Manifests

- **app/sample/manifests/overlays/kind/**:
  - **deployment.yaml**: Defines how the app is deployed
  - **service.yaml**: Exposes the app within the cluster
  - **ingress.yaml**: Configures external access to the app

### 🔄 ArgoCD Configuration

- **manifests/argocd-base-cm.yaml**: ArgoCD base configuration
- **manifests/deploy-argocd-ingress.yaml**: Exposes ArgoCD UI externally
- **manifests/deploy-ingress-nginx.yaml**: Sets up the NGINX ingress controller
- **manifests/sample-app.yaml**: Defines how ArgoCD should deploy our sample app

## 🚀 Getting Started

### Step 1: Setup the Demo Environment

Run the setup script to create a fully working environment:

```sh
make setup
```

Or run the script directly:

```sh
./setup.sh
```

The setup process will:
1. Verify prerequisites (Docker, kind, kubectl)
2. Create a Kubernetes cluster using Kind
3. Install and configure ArgoCD
4. Deploy the NGINX ingress controller
5. Configure ingress routes
6. Deploy the sample FastAPI application using ArgoCD
7. Provide ArgoCD credentials

### Step 2: Explore the Environment

After setup completes:

- **Sample Application**: http://localhost:8000/sample
- **ArgoCD UI**: http://localhost:8000/argocd
  - Username: admin
  - Password: (provided at the end of setup)

### Step 3: Understand the GitOps Flow

1. Examine how ArgoCD is monitoring the Git repository
2. Make changes to the application manifests
3. Watch ArgoCD detect and apply the changes automatically

### Step 4: Cleanup

When you're done exploring, clean up with:

```sh
make cleanup
```

Or run the script directly:

```sh
./cleanup.sh
```

## 📚 Learning Resources

- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Kind Documentation](https://kind.sigs.k8s.io/)
- [GitOps Principles](https://www.gitops.tech/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)

## 📝 License

This project is licensed under the MIT License.
