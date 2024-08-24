locals {
  name = "ex-tmcdapne2"

  container_name = "ecs-sample"
  container_port = 80

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ecs"
  }
}
