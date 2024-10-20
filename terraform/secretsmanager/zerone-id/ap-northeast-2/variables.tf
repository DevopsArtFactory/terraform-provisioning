variable "aws_region" {
  description = "aws region"
  default     = "ap-northeast-2"
}

variable "rotation_lambda_arn" {
  description = "Rotation Lambda Function"
}

variable "multiuser_rotation_lambda_arn" {
  description = "Rotation Lambda Function"
  default     = ""
}

variable "automatically_after_days" {
  description = ""
}