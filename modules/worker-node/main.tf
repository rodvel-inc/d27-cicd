terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "worker" {
  name = var.image_name
}

resource "docker_container" "worker" {
  name  = var.container_name
  image = docker_image.worker.image_id
  
  networks_advanced {
    name    = var.network_id
  }

  env = [
    "DATABASE_HOST=${var.db_host}",
    "DATABASE_PORT=5432",
    "DATABASE_NAME=${var.db_name}",
    "DATABASE_USER=${var.db_user}",
    "DATABASE_PASSWORD=${var.db_password}",
    "REDIS_HOST=${var.redis_host}",
    "REDIS_PORT=6379",
    "WORKER_PORT=3000"
  ]

  # Healthcheck para verificar que la app Flask responde
  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:3000/healthz"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
    start_period = "40s"
  }

  restart = "unless-stopped"
}

