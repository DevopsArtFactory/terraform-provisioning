# Docker 이미지 생성
resource "docker_image" "nginx" {
  name         = "nginx:mainline"
  keep_locally = false
}

# Docker 컨테이너 생성
resource "docker_container" "nginx" {
  count = var.deploy_container ? 1 : 0 # 조건문을 사용하여 컨테이너 생성 여부 결정
  image = docker_image.nginx.image_id
  name  = "nginx_container"
  ports {
    internal = 80
    external = var.container_external_port
  }
  lifecycle {
    # Prevent use Known port
    precondition {
      condition = var.container_external_port != 80 
      error_message = "Don't use Known port(http)"
    }
    # Nginx container cannot created!
    postcondition {
      condition = can(self.id)
      error_message = "Nginx container cannot created!!!"
    }
  }
}

output "docker_container_id" {
  value = docker_container.nginx[0].id
  precondition {
    condition = docker_container.nginx[0].id != ""
    error_message = "Don't Destroy"
  }
}