external_ports = {
  nginx  = 80
  result = 3010
}

database_volume_name = "db-data-prod"

/*
# Producción - Máximos recursos con LocalStack
app_name      = "roxs-voting-prod"
replica_count = 3
memory_limit  = 1024

enable_monitoring = true
backup_enabled    = true

# Configuración específica de LocalStack
aws_region          = "us-east-1"
localstack_endpoint = "http://localhost:4566"
s3_bucket_suffix    = "prod"
*/