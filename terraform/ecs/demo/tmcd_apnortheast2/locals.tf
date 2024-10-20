locals {
  name = "demo-tmcdapne2"

  container_name = "demo"
  container_port = 8080
  image          = "066346343248.dkr.ecr.ap-northeast-2.amazonaws.com/demoapp:d2edeae84"
  tags = {
    Name = local.name
  }
}
