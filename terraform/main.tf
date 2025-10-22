terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "docker_image" {
  description = "Docker image name for K8s deployment"
  type        = string
  default     = "inventory:latest"
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 8000
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "replicas" {
  description = "Number of replicas for K8s deployment"
  type        = number
  default     = 1
}

# Kubernetes Namespace
resource "kubernetes_namespace" "inventory" {
  metadata {
    name = "inventory-${var.environment}"
  }
}

# Kubernetes Deployment
resource "kubernetes_deployment" "inventory_fastapi" {
  metadata {
    name      = "inventory-fastapi"
    namespace = kubernetes_namespace.inventory.metadata[0].name
    labels = {
      app         = "inventory"
      environment = var.environment
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "inventory"
      }
    }

    template {
      metadata {
        labels = {
          app         = "inventory"
          environment = var.environment
        }
      }

      spec {
        container {
          name  = "fastapi-app"
          image = var.docker_image

          port {
            container_port = var.app_port
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = var.app_port
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/"
              port = var.app_port
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}

# Kubernetes Service
resource "kubernetes_service" "inventory_service" {
  metadata {
    name      = "inventory-service"
    namespace = kubernetes_namespace.inventory.metadata[0].name
  }

  spec {
    type = "NodePort"
    selector = {
      app = "inventory"
    }

    port {
      protocol    = "TCP"
      port        = var.app_port
      target_port = var.app_port
      node_port   = 30008
    }
  }
}

# Fetch Minikube IP
data "external" "minikube_ip" {
  program = ["bash", "-c", "echo '{\"ip\":\"'$(minikube ip)'\"}'"]
}

# Outputs
output "kubernetes_namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace.inventory.metadata[0].name
}

output "kubernetes_service_url" {
  description = "Kubernetes service URL"
  value       = "http://${chomp(data.external.minikube_ip.result.ip)}:30008"
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    image       = var.docker_image
    environment = var.environment
    replicas    = var.replicas
    port        = var.app_port
  }
}
