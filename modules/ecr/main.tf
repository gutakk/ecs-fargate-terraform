resource "aws_ecr_repository" "main" {
  name = var.app_name

  tags = {
    Owner = var.owner
  }
}
