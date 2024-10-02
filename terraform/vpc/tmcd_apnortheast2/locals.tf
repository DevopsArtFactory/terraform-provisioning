resource "random_string" "suffix" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}

locals {
  vpc_name         = replace("${var.product}${var.env_suffix}_${var.aws_region}", "-", "")
  shard_id         = var.shard_id
  eks_cluster_name = format("%s%s%s-%s", var.product, var.env_suffix, var.aws_short_region, random_string.suffix.result)
 vpc_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "shared",
    "Name" : "vpc-${local.vpc_name}"
  }
  public_subnets_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "shared"
    "kubernetes.io/role/elb" : 1
  }
  private_subnets_tags = {
    Network = "Private"
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "shared"
    "kubernetes.io/role/internal-elb" : 1
  }
  public_subnets_tags_flat = distinct(flatten([
    for id in aws_subnet.public.*.id : [
      for key, value in local.public_subnets_tags : {
        id    = id
        key   = key
        value = value
      }
    ]
  ]))
  private_subnets_tags_flat = distinct(flatten([
    for id in aws_subnet.private.*.id : [
      for key, value in local.private_subnets_tags : {
        id    = id
        key   = key
        value = value
      }
    ]
  ]))
  
  private_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private.*.id, var.peering_requests) : {
      route_table_id = pair[0]
      cidr_block     = pair[1].cidr_block
      vpc_name       = pair[1].vpc_name
      peering_id     = pair[1].id
    }
  ])

  private_db_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private_db.*.id, var.db_peering_requests) : {
      route_table_id = pair[0]
      cidr_block     = pair[1].cidr_block
      vpc_name       = pair[1].vpc_name
      peering_id     = pair[1].id
    }
  ])

  private_peering_route_list = flatten([
    for pair in setproduct(var.vpc_peering_list, aws_route_table.private.*.id) : [
      for cidr in pair[0].vpc_cidrs : {
        peer_vpc_name  = pair[0].peer_vpc_name
        vpc_cidr       = cidr
        route_table_id = pair[1]
      }
    ]
  ])
}
