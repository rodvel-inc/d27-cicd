terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "results" {
  name = var.image_name
}

resource "docker_container" "results" {
  name  = var.container_name
  image = docker_image.results.image_id

  ports {
    internal = 3010
    external = 3010
  }

  networks_advanced {
    name = var.network_id
  }

  env = [
    "DATABASE_HOST=${var.db_host}",
    "DATABASE_PORT=5432",
    "DATABASE_NAME=${var.db_name}",
    "DATABASE_USER=${var.db_user}",
    "DATABASE_PASSWORD=${var.db_password}",
    "RESULTS_PORT=3010"
  ]

  # Healthcheck para verificar que la app Flask responde
  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:3010/healthz"]
    interval     = "10s"
    timeout      = "5s"
    retries      = 5
    start_period = "40s"
  }

  restart = "unless-stopped"
}

