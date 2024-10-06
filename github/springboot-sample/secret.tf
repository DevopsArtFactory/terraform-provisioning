module "springboot_sample_jpa_assume_iam_role" {
  source        = "../_module/action"
  repository    = local.repository_name
  secret_name   = "ASSUME_IAM_ROLE"
  owner         = var.owner
  secret_string = data.sops_file.springboot_sample_jpa.data["assume_iam_role"]
}

module "springboot_sample_jpa_aws_account_num" {
  source        = "../_module/action"
  repository    = local.repository_name
  secret_name   = "AWS_ACCOUNT_NUM"
  owner         = var.owner
  secret_string = data.sops_file.springboot_sample_jpa.data["aws_account_num"]
}



