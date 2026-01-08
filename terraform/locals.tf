locals {
  database_network_name = coalesce(
    var.database_network_name,
    "devhub-database-${var.environment}-network"
  )

  api_network_name = coalesce(
    var.api_network_name,
    "${var.project_name}-${var.environment}-network"
  )

  api_volume_name = coalesce(
    var.api_volume_name,
    "${var.project_name}-${var.environment}-volume"
  )

  api_runtime_name = coalesce(
    var.api_runtime_name,
    "${var.project_name}-${var.environment}-runtime"
  )

  api_runtime_image_name = coalesce(
    var.api_runtime_image_name,
    "${var.project_name}-${var.environment}-runtime"
  )
}