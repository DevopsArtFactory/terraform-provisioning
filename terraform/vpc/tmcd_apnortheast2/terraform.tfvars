product            = "tmc"
aws_region         = "ap-northeast-2"
aws_short_region   = "apne2"
cidr_numeral       = "10"
availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
billing_tag        = "tmc"
env_suffix         = "d"
shard_id           = "tmcdapne2"

peering_requests = [
    {
        id         = "vpc-065779b9f959ff450"
        vpc_name   = "testd_apnortheast2"
        cidr_block = "10.20.0.0/16"
    }
]

db_peering_requests = [
]

vpc_peering_list = [
  {
    peer_vpc_id   = "vpc-065779b9f959ff450"
    peer_owner_id = "066346343248"
    peer_region   = "ap-northeast-2"
    peer_vpc_name = "testd_apnortheast2"
    vpc_cidrs     = ["10.20.0.0/16"]
  }
]
