terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "zerone-id-apnortheast2-tfstate"
    key            = "provisioning/terraform/eks/tmcd_apnortheast2/tmcdapne2-nhwy/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
