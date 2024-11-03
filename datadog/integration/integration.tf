# Create a new Datadog - Amazon Web Services integration
resource "datadog_integration_aws" "sandbox" {
  account_id = "066346343248"
  role_name  = "DatadogAWSIntegrationRole"
  host_tags  = ["accountId:066346343248", "accountAlias:zerone-id"]
  account_specific_namespace_rules = {
    auto_scaling = false
    opsworks     = false
  }
  excluded_regions = ["us-east-1", "us-west-2"]
}