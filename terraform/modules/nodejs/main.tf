resource "docker_image" "this" {
  name = var.image_name

  build {
    context    = var.build_context
    dockerfile = var.dockerfile
  }
}

resource "docker_container" "this" {
  name    = var.name
  image   = docker_image.this.image_id
  restart = var.restart_policy

  env = [
    "HOST=${var.host}",
    "PORT=${var.external_port}",
    "METRICS_PORT=${var.metrics_port}"
  ]

  volumes {
    volume_name    = var.volume_name
    container_path = "/app"
    read_only      = false
  }

  dynamic "networks_advanced" {
    for_each = var.network_names

    content {
      name = networks_advanced.value
    }
  }
}
