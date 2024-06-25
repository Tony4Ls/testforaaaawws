resource "aws_lb" "moodle" {
  name               = "moodle-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.eks.cluster_security_group_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.moodle.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.moodle.arn
  }
}

resource "aws_lb_target_group" "moodle" {
  name     = "moodle-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

output "alb_dns_name" {
  value = aws_lb.moodle.dns_name
}
