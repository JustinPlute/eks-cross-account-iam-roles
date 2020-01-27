output "idp_arn" {
  description = "The ARN assigned by AWS to the IdP."
  value       = var.create_idp ? aws_iam_openid_connect_provider._[0].arn : ""
}

output "iam_role_arn" {
  description = "The ARN assigned by AWS to the IAM Role."
  value       = var.create_iam_role ? aws_iam_role._[0].arn : ""
}

output "bucket_domain_name" {
  value       = var.create_s3_bucket ? aws_s3_bucket.bucket[0].bucket_domain_name : ""
  description = "FQDN of S3 Bucket"
}

output "bucket_id" {
  value       = var.create_s3_bucket ? aws_s3_bucket.bucket[0].id : ""
  description = "S3 Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = var.create_s3_bucket ? aws_s3_bucket.bucket[0].arn : ""
  description = "S3 Bucket ARN"
}