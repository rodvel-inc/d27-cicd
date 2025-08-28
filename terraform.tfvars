project_name = "webapp"

network_name = "webapp-network"

database_volume_name = "db-data"

external_ports = {
  nginx  = 80
  result = 3010
}

db_name = "votes"
db_user = "postgres"
db_host = "postgres"

