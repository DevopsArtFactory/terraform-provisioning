product            = "test"
aws_region         = "ap-northeast-2"
aws_short_region   = "apne2"
cidr_numeral       = "20"
availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
billing_tag        = "test"
env_suffix         = "d"
shard_id           = "testdapne2"

peering_requests = [
    {
        id = "pcx-025125d9f044c1d1e"
        vpc_name = "tmcd_apnortheast2"
        cidr_block = "10.10.0.0/16"
    }
]

db_peering_requests = [
]

vpc_peering_list = [
#   {
#     peer_vpc_id   = "vpc-xxxx"
#     peer_owner_id = "xxxx"
#     peer_region   = "ap-northeast-2"
#     peer_vpc_name = "xxxxs_apnortheast2"
#     vpc_cidrs     = ["10.11.0.0/16"]
#   }
]
