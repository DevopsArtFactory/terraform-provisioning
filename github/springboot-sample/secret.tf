module "springboot_sample_assume_iam_role" {
  source        = "../_module/action"
  repository    = local.repository_name
  secret_name   = "ASSUME_IAM_ROLE"
  owner         = var.owner
  secret_string = data.sops_file.springboot_sample.data["assume_iam_role"]
}

module "springboot_sample_aws_account_num" {
  source        = "../_module/action"
  repository    = local.repository_name
  secret_name   = "AWS_ACCOUNT_NUM"
  owner         = var.owner
  secret_string = data.sops_file.springboot_sample.data["aws_account_num"]
}


module "springboot_sample_infra_github_token" {
  source        = "../_module/action"
  repository    = local.repository_name
  secret_name   = "INFRA_GITHUB_TOKEN"
  owner         = var.owner
  secret_string = data.sops_file.springboot_sample.data["infra_github_token"]
}



