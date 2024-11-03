variable "aws_region" {
  description = "The AWS region to deploy the shard storage layer into"
  default     = "us-east-1"
}

variable "datadog_external_id" {
  description = "Datadog External Id"
  default     = "3c42947d62d2431d95c1e41a1ecfeb0c"
}