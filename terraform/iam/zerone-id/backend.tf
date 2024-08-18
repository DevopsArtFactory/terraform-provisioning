terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "zerone-id-apnortheast2-tfstate"
    key            = "provisioning/terraform/iam/zerone-id/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
    # assume role {
    #   role_arn       = "arn:aws:iam::478195486159:role/terraform-runner"
    # }
  }
}
