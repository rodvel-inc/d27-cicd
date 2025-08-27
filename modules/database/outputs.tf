# modules/database/outputs.tf
output "container_name" {
  description = "El nombre del contenedor de la base de datos."
  value       = docker_container.postgres.name
}