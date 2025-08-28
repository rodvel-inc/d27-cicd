variable "project_name" {
  description = "Nombre base para los recursos del proyecto."
  type        = string
}

# --- Variables de Red y Volumen ---
variable "network_name" {
  description = "Nombre de la red Docker personalizada."
  type        = string
}

variable "database_volume_name" {
  description = "Nombre del volumen para la base de datos."
  type        = string
}

# --- Variables de Imágenes Docker ---
variable "images" {
  description = "Mapa con los nombres de las imágenes Docker a utilizar."
  type        = map(string)
  default = {
    vote   = "rodvelinc/vote:latest",
    worker = "rodvelinc/worker:latest",
    result = "rodvelinc/result:latest",
    db     = "postgres:15",
    cache  = "redis:7",
    nginx  = "nginx:alpine"
  }
}

# --- Variables de Configuración de Contenedores ---
variable "database_password" {
  description = "Contraseña para el usuario de la base de datos."
  type        = string
  sensitive   = true
}

variable "external_ports" {
  description = "Puertos a exponer en la máquina anfitriona (host)."
  type = object({
    nginx  = number
    result = number
  })
}

# --- Variables para la autenticación en Docker Hub ---
variable "docker_username" {
  description = "Usuario de Docker Hub."
  type        = string
  nullable    = false
}

variable "docker_token" {
  description = "Token de acceso personal (PAT) de Docker Hub."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "db_name" {
  description = "Nombre para la base de datos PostgreSQL."
  type        = string
  default     = "votes"
}

variable "db_user" {
  description = "Usuario para la base de datos PostgreSQL."
  type        = string
  default     = "postgres"
}

variable "db_host" {
  description = "Usuario para la base de datos PostgreSQL."
  type        = string
  default     = "postgres"
}

