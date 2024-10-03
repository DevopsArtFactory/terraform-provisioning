# resource "aws_ec2_tag" "vpc_tags" {
#   for_each    = local.vpc_tags
#   resource_id = aws_vpc.default.id
#   key         = each.key
#   value       = each.value
# }
# resource "aws_ec2_tag" "public_subnet_tags" {
#   for_each    = { for entry in local.public_subnets_tags_flat : "${entry.id}_${entry.key}" => entry }
#   resource_id = each.value.id
#   key         = each.value.key
#   value       = each.value.value
# }
# resource "aws_ec2_tag" "private_subnet_tags" {
#   for_each    = { for entry in local.private_subnets_tags_flat : "${entry.id}_${entry.key}" => entry }
#   resource_id = each.value.id
#   key         = each.value.key
#   value       = each.value.value
# }