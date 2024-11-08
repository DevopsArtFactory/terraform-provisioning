locals {
  collect_role_arn = "arn:aws:iam::066346343248:role/sumologic-role"
  bucket_name      = ""
  sources_data = [
  ]

  sources_data_flattened = flatten([
    for data in local.sources_data : [
      for region in data.target_regions : {
        account_id    = data.account_id
        account_alias = data.account_alias
        target_region = region
      }
    ]
  ])
}
