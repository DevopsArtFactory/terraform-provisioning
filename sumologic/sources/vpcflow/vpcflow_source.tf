# resource "sumologic_s3_source" "vpcflow_source" {
#   for_each      = { for entry in local.sources_data_flattened : "${entry.account_alias}_${entry.target_region}" => entry }
#   name          = "vpcflow-${each.value.account_alias}-${replace(each.value.target_region, "-", "")}"
#   description   = "network traffic data in AWS VPCs for traffic analysis"
#   category      = "vpcflow/${each.value.account_alias}/${each.value.target_region}"
#   content_type  = "AwsS3Bucket"
#   scan_interval = 300000
#   paused        = false
#   collector_id  = data.terraform_remote_state.sumologic_collector.outputs.vpcflow_collector
#   fields = {
#     "account_alias" = each.value.account_alias
#     "account_id"    = each.value.account_id
#   }

#   authentication {
#     type     = "AWSRoleBasedAuthentication"
#     role_arn = local.collect_role_arn
#     region   = "ap-northeast-2"
#   }

#   path {
#     type            = "S3BucketPathExpression"
#     bucket_name     = local.bucket_name
#     path_expression = "AWSLogs/${each.value.account_id}/vpcflowlogs/${each.value.target_region}/*"
#   }
# }
