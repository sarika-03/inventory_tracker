# 📦 Inventory Tracker - FastAPI DevOps Project

<div align="center">

**A full-stack, production-ready DevOps demonstration using FastAPI, Jenkins, Terraform, and Kubernetes.**

![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104-green?style=for-the-badge&logo=fastapi)
![Jinja2](https://img.shields.io/badge/Templating-Jinja2-orange?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-20.10+-blue?style=for-the-badge&logo=docker)
![Jenkins](https://img.shields.io/badge/CI/CD-Jenkins-red?style=for-the-badge&logo=jenkins)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple?style=for-the-badge&logo=terraform)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-blue?style=for-the-badge&logo=kubernetes)

</div>

---

## 💡 Project Overview

This project is a simple **Inventory Management System** built with **FastAPI**. Its primary purpose is to showcase a **complete, automated DevOps pipeline** from code commit to deployment on a Kubernetes cluster.

### Key Features

* **FastAPI Web App:** Uses **Jinja2** to render HTML forms and display the product list.
* **Data Models:** Implemented using **Pydantic** for clear data validation (`models.py`).
* **In-Memory Storage:** Product data is stored in a simple list (`main.py`) for demonstration purposes (data is reset on restart).
* **Containerization:** Packaged using a lightweight **`Dockerfile`**.
* **CI/CD Automation:** Handled by a declarative **`Jenkinsfile`**.
* **Infrastructure as Code (IaC):** **Terraform** manages the creation of Kubernetes resources (`main.tf`).
* **Kubernetes Deployment:** Uses standard **Deployment** and **NodePort Service** for external access.

---

## ⚙️ Project Architecture and DevOps Flow

The project follows a robust CI/CD workflow, automated by Jenkins.

```mermaid
graph TD
    A[🧑‍💻 Developer Commit] --> B{GitHub Repository};
    B --> C[🤖 Jenkins Pipeline Trigger];
    C --> D[Stage 1: Run Tests (Pytest)];
    D --> E[Stage 2: Docker Build & Push];
    E --> F[sarika1731/inventory:3.12-slim];
    F --> G[Stage 3: Terraform Apply];
    G --> H[☸️ Kubernetes Cluster];
    H --> I[🌐 Inventory App Running on NodePort 30008];
