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
