output "ecs_cluster_name" {
  value = module.ecs_cluster.name
}

output "ecs_service_name" {
  value = module.ecs_service.name
}

output "ecs_service_arn" {
  value = module.ecs_service.id
}

output "alb_blue_listener_arn" {
  value = module.alb.listeners.blue.arn
}

output "alb_green_listener_arn" {
  value = module.alb.listeners.green.arn
}

output "alb_blue_target_group_name" {
  value = module.alb.target_groups.blue.name
}

output "alb_green_target_group_name" {
  value = module.alb.target_groups.green.name
}