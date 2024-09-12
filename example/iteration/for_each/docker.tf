resource "docker_image" "nginx" {
  name         = "nginx:mainline"
  keep_locally = false
}

resource "docker_container" "nginx" {
  for_each = { for port in var.ports : port.container_name => port }
  image = docker_image.nginx.image_id
  name  = each.key
  network_mode = "bridge"
  ports {
    internal = 80
    external = each.value.port
  }
}

