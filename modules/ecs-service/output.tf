output "target_group_arn" {
  value = aws_lb_target_group.ecs-service.arn
}

output "task_security_group_id" {
  value = aws_security_group.ecs-service.id
}
