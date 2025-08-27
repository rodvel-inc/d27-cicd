# Configuración del proveedor Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

#provider "docker" {}

# Configuración del proveedor Docker con autenticación
provider "docker" {
  registry_auth {
    address  = "https://index.docker.io/v1/"
    username = var.docker_username
    password = var.docker_token
  }
}

# --- Recursos Compartidos ---

# 1. Red Docker personalizada para que los contenedores se comuniquen.
resource "docker_network" "webapp_network" {
  name = var.network_name
}

# 2. Volumen para la persistencia de datos de PostgreSQL.
resource "docker_volume" "db_volume" {
  name = var.database_volume_name
}

# --- Módulos de Contenedores ---

# 3. Base de Datos (PostgreSQL)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "database" {
  source           = "./modules/database"
  container_name   = "${var.project_name}-db"
  image_name       = var.images["db"]
  network_id       = docker_network.webapp_network.id
  volume_name      = docker_volume.db_volume.name
  db_password      = var.database_password
  init_script_path = abspath("${path.root}/modules/database/init.sql")
}

# 4. Caché (Redis)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "cache-service" {
  source         = "./modules/cache-service"
  container_name = "${var.project_name}-cache"
  image_name     = var.images["cache"]
  network_id     = docker_network.webapp_network.id
}

# 5. Aplicación de Votación (Python/Flask)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "vote-service" {
  source         = "./modules/vote-service"
  container_name = "vote-service" # Nombre DNS para Nginx
  image_name     = var.images["vote"]
  network_id     = docker_network.webapp_network.id
  redis_host     = module.cache-service.container_name
}

# 6. Proxy Inverso (Nginx)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "nginx-service" {
  source           = "./modules/proxy-service"
  container_name   = "${var.project_name}-nginx"
  image_name       = var.images["nginx"]
  network_id       = docker_network.webapp_network.id
  external         = var.external_ports.nginx
  init_script_path = abspath("${path.root}/modules/proxy-service/nginx.conf")

  depends_on = [
    module.vote-service
  ]
}

# 7. Worker (Node.js)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "worker-node" {
  source         = "./modules/worker-node"
  container_name = "${var.project_name}-worker"
  image_name     = var.images["worker"]
  network_id     = docker_network.webapp_network.id

  # Conexión a la base de datos
  db_host     = module.database.container_name
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.database_password

  # Conexión a Redis
  redis_host = module.cache-service.container_name

  # Dependencia explícita para asegurar el orden de arranque
  depends_on = [
    module.database,
    module.cache-service
  ]
}

# 8. Results (Node.js)
# input_del_módulo_hijo = valor_del_módulo_raíz
# ---------------------   ---------------------
module "results-node" {
  source         = "./modules/results-node"
  container_name = "${var.project_name}-results"
  image_name     = var.images["result"]
  network_id     = docker_network.webapp_network.id

  # Conexión a la base de datos
  db_host     = module.database.container_name
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.database_password

  # Dependencia explícita para asegurar el orden de arranque
  depends_on = [
    module.database
  ]
}