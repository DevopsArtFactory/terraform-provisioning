# 환경 변수 정의
variable "environment" {
  description = "배포할 환경을 지정합니다. (예: dev, staging, prod)"
  type        = string
  default     = "dev"
}

# 사용자 입력 변수 정의
variable "enable_volume" {
  description = "볼륨을 마운트할지 여부를 결정합니다."
  type        = bool
  default     = true
}

variable "memory_limit" {
  description = "컨테이너에 할당할 메모리 제한 (MB)"
  type        = number
  default     = 512
}

variable "host_path" {
  default = ""
}

variable "container_path" {
  default = "/usr/share/nginx/html"
}