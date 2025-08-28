terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "vote" {
  name = var.image_name
}

resource "docker_container" "vote" {
  name  = var.container_name
  image = docker_image.vote.image_id

  networks_advanced {
    name    = var.network_id
    aliases = ["vote-service"] # Alias DNS para que Nginx lo encuentre
  }

  # Inyectamos las variables del .env como variables de entorno del contenedor
  env = [
    "REDIS_HOST=${var.redis_host}",
    "REDIS_PORT=${var.redis_port}"
  ]

  # Healthcheck para verificar que la app Flask responde
  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:80/"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }

  restart = "always"
}