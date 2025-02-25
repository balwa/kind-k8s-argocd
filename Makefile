.PHONY: setup cleanup clean help

help:
	@echo "🚢 GitOps Demo with Kind, Kubernetes, and ArgoCD"
	@echo ""
	@echo "Available targets:"
	@echo "  setup    - Set up the Kubernetes cluster with ArgoCD and deploy the sample application"
	@echo "  cleanup  - Delete the Kubernetes cluster"
	@echo "  clean    - Run cleanup and setup in sequence (restart environment)"
	@echo "  help     - Show this help message"

setup:
	@./setup.sh

cleanup:
	@./cleanup.sh

clean:
	@echo "🧹 Cleaning up and restarting environment..."
	@make cleanup 
	@make setup