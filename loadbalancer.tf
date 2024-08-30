resource "aws_lb_target_group" "languagetool" {
  name        = "languagetool"
  port        = local.languagetool_port
  target_type = "ip"
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 2
    path                = "/v2/healthcheck"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
}

resource "aws_lb" "languagetool" {
  name               = "languagetool"
  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  security_groups    = [aws_default_security_group.default.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_listener" "languagetool" {
  load_balancer_arn = aws_lb.languagetool.arn
  port              = local.languagetool_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.languagetool.arn
  }
}
