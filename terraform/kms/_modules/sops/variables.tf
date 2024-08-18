variable "alias" {
  description = "alias"
  type        = string
}


variable "allowed_account_ids" {
  description = "AWS account IDs able to use this KMS key."
  type        = list(string)
  validation {
    condition     = alltrue([for id in var.allowed_account_ids : can(regex("^[0-9]{12}$", id))])
    error_message = "The values must be AWS account ID."
  }
}

variable "allowed_role_arns" {
  description = "AWS AssumeRole role ARNs able to use this KMS key."
  type        = list(string)
  validation {
    condition     = alltrue([for id in var.allowed_role_arns : can(regex("^arn:aws:iam::[0-9]{12}", id))])
    error_message = "The values must be AWS IAM ARN"
  }
}
