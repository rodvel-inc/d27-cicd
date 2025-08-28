# Configuración del proveedor Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}


resource "docker_image" "postgres" {
  name = var.image_name
}

resource "docker_container" "postgres" {
  name  = var.container_name
  image = docker_image.postgres.image_id
  networks_advanced {
    name = var.network_id
  }

  # Variables de entorno para configurar PostgreSQL
  env = [
    "POSTGRES_DB=votes",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  # Montaje del volumen para persistencia
  volumes {
    volume_name    = var.volume_name
    container_path = "/var/lib/postgresql/data"
  }

  volumes {
    # 2. Bind mount para el script de inicialización
    host_path      = var.init_script_path
    container_path = "/docker-entrypoint-initdb.d/init.sql"
    read_only      = true
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U $POSTGRES_USER"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }

  # Política de reinicio
  restart = "always"
}