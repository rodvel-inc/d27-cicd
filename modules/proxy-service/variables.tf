variable "external" { type = string}
variable "container_name" { type = string }
variable "image_name" { type = string }
variable "network_id" { type = string }
variable "init_script_path" {
  description = "Ruta al archivo nginx.conf de configuración del proxy."
  type        = string
}