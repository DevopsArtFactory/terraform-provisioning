data "terraform_remote_state" "kms_apne2" {
  backend = "s3"

  config = merge(var.remote_state.kms.lgudax.apne2, { "role_arn" = var.assume_role_arn })
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.daxapne2, { "role_arn" = var.assume_role_arn })
}


