resource "aws_kms_key" "ssm-parameters" {
  count                   = var.at_rest_encryption ? 1 : 0
  description             = "SSM Paramstore key ${var.prefix}"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}
resource "aws_kms_alias" "ssm-parameters" {
  count         = var.at_rest_encryption ? 1 : 0
  name          = "alias/ssm-paramstore-${var.prefix}"
  target_key_id = aws_kms_key.ssm-parameters[0].key_id
}


