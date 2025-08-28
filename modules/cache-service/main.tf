terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_image" "redis" {
  name = var.image_name
}

resource "docker_container" "redis" {
  name  = var.container_name
  image = docker_image.redis.image_id
  networks_advanced {
    name = var.network_id
  }

  healthcheck {
    test     = ["CMD", "redis-cli", "ping"]
    interval = "5s"
    timeout  = "3s"
    retries  = 5
  }
  restart = "always"


}