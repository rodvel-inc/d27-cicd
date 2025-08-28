# outputs.tf

output "vote_app_url" {
  description = "URL para acceder a la aplicación de votación."
  value       = "http://localhost:${var.external_ports.nginx}"
}

output "result_app_url" {
  description = "URL para ver los resultados de la votación."
  value       = "http://localhost:${var.external_ports.result}"
}

output "network_name" {
  description = "Nombre de la red Docker creada."
  value       = docker_network.webapp_network.name
}

output "database_container_name" {
  description = "Nombre del contenedor de la base de datos."
  value       = module.database.container_name
}

output "cache_container_name" {
  description = "Nombre del contenedor de Redis."
  value       = module.cache-service.container_name
}