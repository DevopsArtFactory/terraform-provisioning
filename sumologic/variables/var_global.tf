variable "remote_state" {
  default = {
    roles = {
      region = "ap-northeast-2"
      bucket = "zerone-id-apnortheast2-tfstate"
      key    = "provisioning/sumologic/roles/terraform.tfstate"
    }
    collector = {
      region = "ap-northeast-2"
      bucket = "zerone-id-apnortheast2-tfstate"
      key    = "provisioning/sumologic/collector/terraform.tfstate"
    }
  }
}

