terraform {
  required_version = ">= 1.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
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


provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "docker_image" {
  description = "Docker image name from Jenkins"
  type        = string
  default     = "sarika1731/inventory:3.12-slim"
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "inventory-tracker-app"
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

resource "docker_image" "inventory_app" {
  name         = var.docker_image
  keep_locally = false
}

resource "docker_container" "inventory_app" {
  name  = var.container_name
  image = docker_image.inventory_app.image_id

  ports {
    internal = var.app_port
    external = var.app_port
  }

  restart = "unless-stopped"

  env = [
    "ENVIRONMENT=${var.environment}",
    "PORT=${var.app_port}"
  ]
}

resource "kubernetes_namespace" "inventory" {
  metadata {
    name = "inventory-${var.environment}"
  }
}

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
  program = ["bash", "-c", "minikube ip | jq -R -n --arg ip $(cat) '{ip:$ip}'"]
}

output "docker_container" {
  description = "Container ID of the deployed app"
  value       = docker_container.inventory_app.id
}

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
