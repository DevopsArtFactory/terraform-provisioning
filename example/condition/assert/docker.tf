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
    external = 8080
  }
}

check "health_check" {
  data "http" "nginx" {
    url = "http://localhost:8080"
  }

  assert {
    condition = data.http.nginx.status_code != 200
    error_message = "${data.http.nginx.url} returned an unhealthy status code"
  }
}