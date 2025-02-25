#!/bin/bash

echo "======================================================================"
echo "🧹 Cleaning up the Kubernetes cluster"
echo "======================================================================"
echo "Deleting Kind cluster..."
kind delete cluster --name=argo-ci-cd
echo "✅ Cluster deleted successfully"
echo
echo "======================================================================"
echo "🏁 Cleanup Complete!"
echo "======================================================================"