resource "aws_security_group" "ecs-service" {
  name        = var.application_name
  vpc_id      = var.vpc_id
  description = var.application_name

dynamic ingress {
  for_each = var.ingress_rules
  content {
    from_port = ingress.value.from_port
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}