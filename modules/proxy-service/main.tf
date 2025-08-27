terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "nginx" {
  name = var.image_name
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 80
  }

  networks_advanced {
    name    = var.network_id
    }
volumes {
    # 2. Bind mount para el script de inicialización
    host_path      = var.init_script_path
    container_path = "/etc/nginx/conf.d/vote.conf"
    read_only      = true
  }

  command = [
    "/bin/sh",
    "-c",
    "rm -f /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
  ]
  
  # Healthcheck para verificar que nginx responde
  healthcheck {
    test     = ["CMD", "wget", "-qO-", "http://localhost/health"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }
  
}