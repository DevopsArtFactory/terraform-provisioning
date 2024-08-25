resource "aws_codedeploy_app" "demo_app" {
  compute_platform = "ECS"
  name             = "demo_app"
}

resource "aws_codedeploy_deployment_group" "demo_app" {
  app_name               = aws_codedeploy_app.demo_app.name
  deployment_config_name = aws_codedeploy_deployment_config.demo_app.id
  deployment_group_name  = "demo_app"
  service_role_arn       = data.terraform_remote_state.iam.outputs.codedeploy_deployment_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = data.terraform_remote_state.demo_tmcdapne2.outputs.ecs_cluster_name
    service_name = data.terraform_remote_state.demo_tmcdapne2.outputs.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [data.terraform_remote_state.demo_tmcdapne2.outputs.alb_blue_listener_arn]
      }
      test_traffic_route {
        listener_arns = [data.terraform_remote_state.demo_tmcdapne2.outputs.alb_green_listener_arn]
      }

      target_group {
        name = data.terraform_remote_state.demo_tmcdapne2.outputs.alb_blue_target_group_name
      }

      target_group {
        name = data.terraform_remote_state.demo_tmcdapne2.outputs.alb_green_target_group_name
      }
    }
  }
}

resource "aws_codedeploy_deployment_config" "demo_app" {
  deployment_config_name = "demo_app"
  compute_platform = "ECS"
  traffic_routing_config {
    type = "AllAtOnce"
  }
}

output "demo_app_codedeploy_app_arn" {
  value = aws_codedeploy_app.demo_app.arn
}


output "demo_app_codedeploy_deployment_group_arn" {
  value = aws_codedeploy_deployment_group.demo_app.arn
}


output "demo_app_codedeploy_deployment_config_arn" {
  value = aws_codedeploy_deployment_config.demo_app.arn
}