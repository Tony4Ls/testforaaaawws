resource "aws_lb" "alb" {
  name               = "moodle-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.private_subnets

  tags = {
    Name = "moodle-alb"
  }
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "moodle-alb-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "moodle-alb-sg"
  }
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
