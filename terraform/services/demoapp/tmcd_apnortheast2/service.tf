# Use module for service
module "demoapp" {
  source = "../_module/service"

  # Name of service
  service_name = "demoapp"

  # Port for service and healthcheck
  service_port     = 8080
  healthcheck_port = 8080
  healthcheck_path = "/actuator/health"

  # VPC Information via remote_state
  shard_id                 = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets           = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_region               = data.terraform_remote_state.vpc.outputs.aws_region
  vpc_cidr_numeral         = data.terraform_remote_state.vpc.outputs.cidr_numeral
  target_vpc               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name                 = data.terraform_remote_state.vpc.outputs.vpc_name

  # Domain Name 
  # This will be the prefix of record 
  # e.g) demoapp.terraform.devart.tf
  domain_name = "demoapp"

  # Route53 variables
  acm_external_ssl_certificate_arn = var.r53_variables.star_terraform_devart_tv_acm_apne2_arn
  route53_external_zone_id         = var.r53_variables.terraform_devart_tv_zone_id

  # Resource LoadBalancer variables
  lb_variables = var.lb_variables

  # Security Group variables
  sg_variables = var.sg_variables

  # CIDR for external LB
  # Control allowed IP for external LB 
  ext_lb_ingress_cidrs = [
    "121.136.217.18/32"
  ]
}
