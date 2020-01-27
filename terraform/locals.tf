locals {
  bucket_name = var.bucket_name ? var.bucket_name : "${local.account_id}-${data.aws_region.current.name}-nodejs-s3"
  region = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id
}