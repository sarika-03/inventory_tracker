# Terraform: Run a local hello-world Docker container (for DevOps learners only)

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "hello_world" {
  name         = "hello-world"
  keep_locally = true
}

resource "docker_container" "hello_world" {
  name  = "tf-hello-world-demo"
  image = docker_image.hello_world.name
}
