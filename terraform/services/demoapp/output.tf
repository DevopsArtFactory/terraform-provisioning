output "aws_security_group_ec2_id" {
  description = "demoapp name node security group"
  value       = module.demoapp.aws_security_group_ec2_id
}

