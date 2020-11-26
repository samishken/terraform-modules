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
  count             = var.ssl ? 1 : 0
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "elbsecuritypolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.certificate.arn

  dynamic default_action {
    for_each = var.default_target_arn == "" ? [] : [1]
    content {
      target_group_arn = var.default_target_arn
      type             = "forward"
    }
  }

  dynamic default_action {
    for_each = var.default_target_arn == "" ? [1] : []
    content {
      type = "fixed-response"
      fixed_response {
        content_type = "text/plain"
        message_body = "No service configured at this address"
        status_code  = 404
      }
    }
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

