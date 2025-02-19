# Kind K8s ArgoCD

This project sets up a Kubernetes cluster using `kind` and deploys a sample FastAPI application with ArgoCD for continuous deployment. It also configures an NGINX ingress controller.

## Prerequisites

- Docker
- kind
- kubectl

## Key Files

- **setup.sh**: Script to set up the Kubernetes cluster and deploy the application.
- **cleanup.sh**: Script to delete the Kubernetes cluster.
- **Makefile**: Makefile to simplify setup and cleanup tasks.
- **kind.yaml**: Configuration file for the kind cluster.
- **.github/workflows/build-image-update-manifest.yaml**: GitHub Actions workflow to build and push Docker images and update the deployment manifest.

## Application Files

- **app/sample/Dockerfile**: Dockerfile to build the FastAPI application image.
- **app/sample/main.py**: FastAPI application code.
- **app/sample/requirements.txt**: Python dependencies for the FastAPI application.
- **app/sample/manifests/overlays/kind/deployment.yaml**: Kubernetes deployment manifest for the FastAPI application.
- **app/sample/manifests/overlays/kind/ingress.yaml**: Kubernetes ingress manifest for the FastAPI application.
- **app/sample/manifests/overlays/kind/service.yaml**: Kubernetes service manifest for the FastAPI application.

## Manifests

- **manifests/argocd-base-cm.yaml**: ConfigMap for ArgoCD.
- **manifests/deploy-argocd-ingress.yaml**: Ingress manifest for ArgoCD.
- **manifests/deploy-ingress-nginx.yaml**: Manifests to deploy the NGINX ingress controller.
- **manifests/sample-app.yaml**: ArgoCD application manifest for the sample FastAPI application.

## Setup

To set up the Kubernetes cluster and deploy the application, run:

```sh
make setup
```

This will:

1. Check if Docker, kind, and kubectl are installed.
1. Create a kind cluster using the configuration in kind.yaml.
1. Create the argocd namespace and install ArgoCD.
1. Deploy the NGINX ingress controller.
1. Apply the ArgoCD base ConfigMap.
1. Wait for the ingress controller to be ready.
1. Deploy the ArgoCD ingress.
1. Deploy the sample FastAPI application.
1. Retrieve the ArgoCD initial admin password.

Cleanup
To delete the Kubernetes cluster, run:

```sh
make cleanup
```

## Accessing the Application

Once the setup is complete, you can access the FastAPI application at http://localhost:8000/sample.

## License

This project is licensed under the MIT License.
