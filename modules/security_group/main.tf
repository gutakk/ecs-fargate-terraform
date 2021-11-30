resource "aws_security_group" "lb-sg" {
  name        = "${var.app_name}-allow-all-lb"
  description = "${var.app_name} ALB Security Group"
  vpc_id      = var.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app_name}-allow-all-lb"
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "aws_security_group" "ecs-fargate-sg" {
  name        = "${var.app_name}-ecs-fargate-sg"
  description = "${var.app_name} ECS Fargate Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app_name}-ecs-fargate-sg"
    Owner       = var.owner
    Environment = var.environment
  }
}
