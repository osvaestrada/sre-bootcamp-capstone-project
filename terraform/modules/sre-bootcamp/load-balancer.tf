resource "aws_security_group" "load_balancer" {
  name        = "load-balancer-${var.env}"
  description = "Load Balancer Security Group"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from the internet"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "load balancer-${var.env}"
  }

}

resource "aws_lb" "lb_sre_bootcamp" {
  name               = "sre-bootcamp-${var.env}"
  load_balancer_type = "application"
  internal           = false
  subnets = [ # Referencing the default subnets
    "${aws_default_subnet.default_subnet_b.id}",
    "${aws_default_subnet.default_subnet_c.id}"
  ]
  security_groups = [aws_security_group.load_balancer.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "lb_target" {
  name        = "tf-lb-tg-${var.env}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id

  health_check {
    matcher = "200,301,302"
    path    = "/"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb_sre_bootcamp.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.lb_target.arn
    type             = "forward"
  }
}