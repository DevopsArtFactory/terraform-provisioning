locals {
  name = "demo-tmcdapne2"

  container_name = "demo"
  container_port = 8080
  image          = "066346343248.dkr.ecr.ap-northeast-2.amazonaws.com/sample:9d06203d"
  tags = {
    Name = local.name
  }
}
