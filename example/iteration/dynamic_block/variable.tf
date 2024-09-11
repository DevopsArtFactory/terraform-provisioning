variable "ports" {
  type = list(object({
    internal = number
    external = number
  }))
  default = [
    { internal = 80, external = 8080 },
    { internal = 80, external = 8443 }
  ]
}