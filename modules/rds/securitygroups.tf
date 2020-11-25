resource "aws_security_group" "rds" {
  name        = "${var.name}-rds"
  vpc_id      = var.vpc_id
  description = "${var.name}-rds"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.ingress_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

