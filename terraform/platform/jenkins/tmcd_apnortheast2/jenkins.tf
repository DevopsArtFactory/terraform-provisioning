module "jenkins" {
  source       = "../_modules/jenkins"
  service_name = "jenkins"

  shard_id        = data.terraform_remote_state.vpc.outputs.shard_id
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets #not use
  public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnets 
  aws_region      = data.terraform_remote_state.vpc.outputs.aws_region
  target_vpc      = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name        = data.terraform_remote_state.vpc.outputs.vpc_name

  deployment_common_arn = data.terraform_remote_state.kms_apne2.outputs.aws_kms_key_apne2_deployment_common_arn

  ssl_certificate_id       = var.r53_variables.star_terraform_devart_tv_acm_apne2_arn
  route53_external_zone_id = var.r53_variables.terraform_devart_tv_zone_id

  efs_throughput_mode                 = "provisioned"
  efs_provisioned_throughput_in_mibps = 8
  enable_external                     = true
  enable_internal                     = false
  # Project related variables
  ingress_cidr_blocks = ["121.136.217.18/32"]
  egress_cidr_blocks  = ["10.0.0.0/8"]
  project_tags        = var.tags
}

