resource "datadog_monitor" "atlantis_service_running_count" {
  name               = "Atlantis ECS Service Running Count 0"
  type               = "metric alert"
  message            = <<EOF
ECS Cluster Atlantis Service running Count is 0.
Check Atlatis ECS Cluster {{service.name}} in {{accountalias.name}}
@slack-DevOps_Study-demo
EOF
 
  query = "sum(last_5m):sum:aws.ecs.service.running{service:atlantis} by {service,accountalias} == 0"

  monitor_thresholds {
    critical = 0
  }

  include_tags = true

  tags = ["service:atlantis", "accountalias:zerone-id"]
}