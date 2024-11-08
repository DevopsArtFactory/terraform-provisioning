# resource "aws_flow_log" "flowlog" {
#   log_destination      = data.terraform_remote_state.s3.outputs.tmcdapne2_vpcflow_log_s3_bucket_arn
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = aws_vpc.default.id
# }