resource "aws_lb" "lb" {
  name               = "${var.app_name}-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.public_subnets
  security_groups    = var.security_group_ids
  tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name                 = "${var.app_name}-target-group"
  port                 = "80"
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = 5
  health_check {
    path                = "/api/v1/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 5
    port                = 80
    protocol            = "HTTP"
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
