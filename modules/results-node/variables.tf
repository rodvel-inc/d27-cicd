variable "container_name" {
  description = "Nombre para el contenedor del worker."
  type        = string
}

variable "image_name" {
  description = "Nombre de la imagen Docker a utilizar (ej: rodvelinc/worker:latest)."
  type        = string
}

variable "network_id" {
  description = "ID de la red Docker a la que se conectará el contenedor."
  type        = string
}

# --- Variables de Conexión a la Base de Datos ---
variable "db_host" {
  description = "Host del contenedor de la base de datos."
  type        = string
}
variable "db_name" {
  description = "Nombre de la base de datos."
  type        = string
}
variable "db_user" {
  description = "Usuario de la base de datos."
  type        = string
}
variable "db_password" {
  description = "Contraseña de la base de datos."
  type        = string
  sensitive   = true
}

