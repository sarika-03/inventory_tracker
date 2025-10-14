# inventory_tracker

## 📦 Local Terraform Demo (DevOps Learning)

This project includes a `/terraform` folder with a simple example to run a local Docker container using Terraform for learning purposes only.

**How to try:**
1. Install [Terraform](https://www.terraform.io/downloads)
2. Go to the `/terraform` directory
3. Run:
   ```sh
   terraform init
   terraform apply
   ```
   This will provision a demo Docker container as described in the `.tf` script.

## ☸️ Kubernetes Sample (k8s)

A `/k8s` folder contains Kubernetes YAML files for deploying this FastAPI app locally (for learning/demo only).

**How to try (minikube or kind recommended):**
1. Go to the `/k8s` directory
2. Run:
   ```sh
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   ```
3. Access the app using the ClusterIP/NodePort as shown by `kubectl get services`. (Check deployment and use `kubectl port-forward` if needed.)

Both setups are kept simple for DevOps learners' exploration. For details see respective directories and `.yaml`/`.tf` comments.