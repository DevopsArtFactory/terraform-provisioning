resource "sumologic_partition" "vpcflowlog" {
  name                          = "vpcflowlog"
  routing_expression            = "_sourcecategory=vpcflow/*"
  analytics_tier                = "continuous"
  is_compliant                  = false
  is_included_in_default_search = false
  lifecycle {
    prevent_destroy = true
  }
}