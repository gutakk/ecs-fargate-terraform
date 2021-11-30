resource "aws_cloudwatch_log_group" "log_group" {
  name              = "awslogs-${var.app_name}-log-group"
  retention_in_days = var.log_retention_in_days

  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}
