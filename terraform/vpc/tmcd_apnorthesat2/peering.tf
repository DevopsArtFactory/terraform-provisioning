resource "aws_vpc_peering_connection" "peering_connection" {
  for_each      = { for entry in var.vpc_peering_list : entry.peer_vpc_name => entry }
  peer_vpc_id   = each.value.peer_vpc_id
  peer_owner_id = each.value.peer_owner_id
  peer_region   = each.value.peer_region
  vpc_id        = aws_vpc.default.id

  tags = {
    Name          = "${var.shard_id}-with-${each.value.peer_vpc_name}"
    peer_vpc_name = each.value.peer_vpc_name
    Side          = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "peering_accepter" {
  for_each                  = { for entry in var.peering_requests : entry.id => entry }
  vpc_peering_connection_id = each.value.id
  auto_accept               = true
  tags = {
    Name = "vpc-peering-${var.shard_id}-with-${each.value.vpc_name}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
