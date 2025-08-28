external_ports = {
  nginx   = 8080
  result = 3010
}

database_volume_name = "db-data-dev"
/*

# Desarrollo - Recursos mínimos con LocalStack
app_name      = "roxs-voting-dev"
replica_count = 1
memory_limit  = 256

enable_monitoring = false
backup_enabled    = false

# Configuracion especifica de localStack
aws_region          = "us-east-1"
localstack_endpoint = "http://localhost:4566"
s3_bucket_suffix    = "dev"
*/

