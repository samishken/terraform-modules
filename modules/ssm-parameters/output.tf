output "kms-key-id" {
  value = aws_kms_key.ssm-parameters.key_id
}
output "kms-key-arn" {
  value = aws_kms_key.ssm-parameters.arn
}
