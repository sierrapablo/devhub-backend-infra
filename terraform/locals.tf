locals {
  database_network_name = coalesce(
    var.database_network_name,
    "devhub-database-${var.environment}-network"
  )

  api_network_name = coalesce(
    var.api_network_name,
    "${var.project_name}-${var.environment}-network"
  )

}