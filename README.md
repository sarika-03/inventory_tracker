# 📦 Inventory Tracker - FastAPI DevOps Project

<div align="center">

![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-green?style=for-the-badge&logo=fastapi)
![Docker](https://img.shields.io/badge/Docker-20.10+-blue?style=for-the-badge&logo=docker)
![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?style=for-the-badge&logo=terraform)
![Jenkins](https://img.shields.io/badge/Jenkins-2.400+-red?style=for-the-badge&logo=jenkins)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28+-blue?style=for-the-badge&logo=kubernetes)

**A complete DevOps pipeline project demonstrating CI/CD, Infrastructure as Code, and containerized deployments**

</div>


## 🌟 Overview

**Inventory Tracker** is a modern, production-ready FastAPI application that demonstrates enterprise-level DevOps practices. This project showcases:

- ✅ **Complete CI/CD Pipeline** with Jenkins
- ✅ **Infrastructure as Code** using Terraform
- ✅ **Container Orchestration** with Kubernetes
- ✅ **Automated Testing** and Quality Checks
- ✅ **Docker Multi-stage Builds** for optimization
- ✅ **GitOps Workflow** with automated deployments

---

🌟 About the Project
Inventory Tracker is a lightweight REST API for managing inventory items. It demonstrates:
API development with FastAPI
Containerization with Docker
CI/CD pipeline with Jenkins
Infrastructure as Code with Terraform
Deployment on Kubernetes

⚡ Features
CRUD API for inventory items (/items)
Health check endpoint (/health)
Swagger UI & ReDoc documentation
Dockerized for local deployment
CI/CD automation and testing

## 🏗️ Tech Stack

<table>
<tr>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width="48" height="48" alt="Python" />
<br><strong>Python 3.12</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg" width="48" height="48" alt="FastAPI" />
<br><strong>FastAPI</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.svg" width="48" height="48" alt="Docker" />
<br><strong>Docker</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" width="48" height="48" alt="Terraform" />
<br><strong>Terraform</strong>
</td>
</tr>
<tr>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/jenkins/jenkins-original.svg" width="48" height="48" alt="Jenkins" />
<br><strong>Jenkins</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/kubernetes/kubernetes-plain.svg" width="48" height="48" alt="Kubernetes" />
<br><strong>Kubernetes</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" width="48" height="48" alt="GitHub" />
<br><strong>GitHub</strong>
</td>
<td align="center" width="150">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/pytest/pytest-original.svg" width="48" height="48" alt="Pytest" />
<br><strong>Pytest</strong>
</td>
</tr>
</table>

🚀 Quick Setup
# Clone repo
git clone https://github.com/sarika-03/inventory_tracker.git
cd inventory_tracker

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r docker/requirements.txt

# Run locally
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# Access API
http://localhost:8000/docs

# Docker Run (Optional)
docker build -f docker/Dockerfile -t inventory-app .
docker run -d -p 8000:8000 inventory-app

# Kubernetes Deploy (Optional)
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods
kubectl get services

flowchart TD
    A[👨‍💻 Developer] -->|Push Code| B[📁 GitHub Repository]
    B --> C[🤖 Jenkins CI/CD Pipeline]
    C --> D[🐳 Docker Build & Push]
    D --> E[🏗️ Terraform Apply Infrastructure]
    E --> F[☸️ Kubernetes Deployment]
    F --> G[🌐 Application Running]

    %% Node styles
    style A fill:#e0f7fa,stroke:#006064,stroke-width:2px
    style B fill:#fff3e0,stroke:#ff9800,stroke-width:2px
    style C fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    style D fill:#f3e5f5,stroke:#6a1b9a,stroke-width:2px
    style E fill:#fff3e0,stroke:#ef6c00,stroke-width:2px
    style F fill:#e3f2fd,stroke:#1565c0,stroke-width:2px
    style G fill:#fce4ec,stroke:#880e4f,stroke-width:2px
