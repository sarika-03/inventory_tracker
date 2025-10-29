# 📦 Inventory Tracker - FastAPI DevOps Project

<div align="center">

**A full-stack, production-ready DevOps demonstration using FastAPI, Jenkins, Terraform, and Kubernetes.**

![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104-green?style=for-the-badge&logo=fastapi)
![Jinja2](https://img.shields.io/badge/Templating-Jinja2-orange?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-20.10+-blue?style=for-for-the-badge&logo=docker)
![Jenkins](https://img.shields.io/badge/CI/CD-Jenkins-red?style=for-the-badge&logo=jenkins)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple?style=for-the-badge&logo=terraform)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-blue?style=for-the-badge&logo=kubernetes)

</div>

---

## 📝 Table of Contents

1.  [💡 Project Overview](#💡-project-overview)
2.  [⚙️ Architecture and DevOps Flow](#⚙️-architecture-and-devops-flow)
3.  [💻 Project Structure](#💻-project-structure)
4.  [🚀 Local Setup (Development)](#🚀-local-setup-development)
5.  [🐳 Docker Setup (Containerization)](#🐳-docker-setup-containerization)
6.  [☸️ Kubernetes Deployment (Production/Staging)](#☸️-kubernetes-deployment-productionstaging)
7.  [🛠️ CI/CD with Jenkins and Terraform](#🛠️-cicd-with-jenkins-and-terraform)

---

## 💡 Project Overview

This project implements a simple **Inventory Management System** using **FastAPI** to track products. Its primary goal is to provide a complete, end-to-end example of modern **DevOps practices**.

### Key Features
* **FastAPI Backend:** Uses **Jinja2** for server-side HTML rendering (a full web app, not just an API).
* **Data Models:** Strict data validation using **Pydantic** (`models.py`).
* **CI/CD Pipeline:** Fully automated workflow defined in **`Jenkinsfile`**.
* **Infrastructure as Code (IaC):** **Terraform** manages the provisioning of Kubernetes resources (`main.tf`).
* **Container Orchestration:** Deployed and managed by **Kubernetes**.

---

## ⚙️ Architecture and DevOps Flow

The project follows a robust CI/CD workflow, where a code change triggers an automated pipeline, leading directly to a production-ready Kubernetes deployment.

```mermaid
graph TD
    A[🧑‍💻 Code Commit to GitHub] --> B(Jenkins Pipeline Triggered);
    B --> C{Stage: Run Unit Tests};
    C --> D[Stage: Docker Build Image];
    D --> E[Stage: Docker Push to sarika1731/inventory];
    E --> F[Stage: Terraform Apply/Deploy to K8s];
    F --> G(☸️ Kubernetes Cluster);
    G --> H[🌐 App Access on NodePort 30008];
