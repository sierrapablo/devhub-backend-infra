module "database_network" {
  source = "./modules/network"

  name     = local.database_network_name
  external = var.database_network_external
}

module "api_network" {
  source = "./modules/network"

  name     = local.api_network_name
  external = var.api_network_external
}

module "api_volume" {
  source = "./modules/volume"

  name = local.api_volume_name

  labels = {
    project     = var.project_name
    environment = var.environment
    purpose     = "api"
  }
}

module "api_runtime" {
  source = "./modules/nodejs"

  name          = local.api_runtime_name
  image_name    = local.api_runtime_image_name
  build_context = var.api_runtime_build_context

  network_names = [
    module.api_network.name,
    module.database_network.name
  ]

  volume_name = module.api_volume.name

  external_port = var.api_external_port
  metrics_port  = var.api_metrics_port
}
