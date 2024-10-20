variable "key_name" {
  description = "Name of Key"
}

variable "tags" {
  description = "Tags for secretsmanager"
}

variable "env" {
  description = "Environment value"
  default     = ""
}

variable "automatically_after_days" {
  description = ""
  default     = 0
}

variable "kms_arn" {
  description = "KMS arn for encrypting secret values"
}

variable "rotation_lambda_arn" {
  description = "Roation Lambda ARN"
}


