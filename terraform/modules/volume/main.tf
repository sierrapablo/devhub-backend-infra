resource "docker_volume" "this" {
  name = var.name

  lifecycle {
    prevent_destroy = false
  }
}