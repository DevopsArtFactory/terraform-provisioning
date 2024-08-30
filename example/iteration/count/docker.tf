resource "docker_image" "nginx" {
  name         = "nginx:mainline"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = length(var.ports)
  image = docker_image.nginx.image_id
  name  = var.ports[count.index].container_name

  ports {
    internal = 80
    external = var.ports[count.index].port
  }
}


