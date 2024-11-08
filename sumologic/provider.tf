terraform {
  required_providers {
    sumologic = {
      source  = "sumologic/sumologic"
      version = "2.31.4"
    }
  }
  required_version = ">= 0.13"
}

provider "sumologic" {
  environment = "kr"
}
