output "aws_route53_zone_id" {
  value = aws_route53_zone.terraform_devart_tv.zone_id
}

output "terraform_devart_tv_domain" {
  value = aws_route53_zone.terraform_devart_tv.name
}
