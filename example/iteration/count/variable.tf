variable "ports" {
  type = list(object({
    container_name = string
    port           = string
  }))

  default = [
    {
      container_name = "test"
      port           = "8080"
    },
    # {
    #   container_name = "test1"
    #   port           = "8081"
    # },
    {
      container_name = "test2"
      port           = "8082"
    },
  ]
}
