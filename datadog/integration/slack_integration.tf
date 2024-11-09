resource "datadog_integration_slack_channel" "devops_study_demo_channel" {
  account_name = "DevOps_Study"
  channel_name = "#demo"

  display {
    message  = true
    notified = true
    snapshot = true
    tags     = true
  }
}