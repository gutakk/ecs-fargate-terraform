output "lb_target_group_arn" {
  value = aws_lb_target_group.lb_target_group.arn
}

output "lb_listener" {
  value = aws_lb_listener.web-listener
}
