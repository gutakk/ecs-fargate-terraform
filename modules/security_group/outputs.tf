output "alb_security_group_ids" {
  value = [aws_security_group.lb-sg.id]
}

output "ecs_security_group_ids" {
  value = [aws_security_group.ecs-fargate-sg.id]
}
