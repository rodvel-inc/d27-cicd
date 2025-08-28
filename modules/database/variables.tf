variable "container_name" { type = string }
variable "image_name" { type = string }
variable "network_id" { type = string }
variable "volume_name" { type = string }
variable "db_password" { type = string }
variable "init_script_path" {
  description = "Ruta al archivo .sql de inicialización para la base de datos."
  type        = string
}