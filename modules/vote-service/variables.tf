variable "container_name" {
  description = "Nombre para el contenedor del servicio de votación."
  type        = string
}

variable "image_name" {
  description = "Nombre de la imagen Docker a utilizar (ej: rodvelinc/vote:latest)."
  type        = string
}

variable "network_id" {
  description = "ID de la red Docker a la que se conectará el contenedor."
  type        = string
}

variable "redis_host" {
  description = "El nombre del host del contenedor de Redis para la conexión."
  type        = string
}

variable "redis_port" {
  description = "El puerto del contenedor de Redis."
  type        = number
  default     = 6379
}