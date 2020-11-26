#
# ecs lb
#
# lb main definition
resource "aws_lb" "lb" {
  name            = var.lb_name
  internal        = var.internal
  security_groups = [aws_security_group.lb.id]
  subnets         = var.vpc_subnets

  enable_deletion_protection = false
}

# certificate
data "aws_acm_certificate" "certificate" {
  domain   = var.domain
  statuses = ["ISSUED", "PENDING_VALIDATION"]
}

# lb listener (https)
resource "aws_lb_listener" "lb-https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "elbsecuritypolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.certificate.arn

  default_action {
    target_group_arn = var.default_target_arn
    type             = "forward"
  }
}

# lb listener (http)
resource "aws_lb_listener" "lb-http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.default_target_arn
    type             = "forward"
  }
}

