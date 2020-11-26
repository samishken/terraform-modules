resource "aws_security_group" "ecs-service" {
  name        = var.application_name
  vpc_id      = var.vpc_id
  description = var.application_name

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}