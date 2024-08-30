# Docker 이미지 생성
resource "docker_image" "nginx" {
  name         = "nginx:mainline"
  keep_locally = false
}

# Docker 컨테이너 생성
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx_container_${var.environment}"

  ports {
    internal = 80
    external = var.environment == "prod" ? 80 : 8080
  }

  # 특정 조건에 따른 볼륨 마운트
  dynamic "volumes" {
    for_each = var.enable_volume ? [1] : []
    content {
      host_path      = var.host_path
      container_path = var.container_path
    }
  }

  # 메모리 제한 설정
  memory = var.memory_limit * 1024 * 1024 # MB to Bytes

  # 재시작 정책 설정
  restart = var.environment == "prod" ? "on-failure" : "unless-stopped"

  # 환경 변수 설정
  env = [
    "ENV=${var.environment}",
    "MEMORY_LIMIT=${var.memory_limit}MB"
  ]
}