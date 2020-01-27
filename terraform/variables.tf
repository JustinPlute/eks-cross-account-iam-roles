#--------------------------------------------------------------
# Cluster Information
#--------------------------------------------------------------
variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = ""
}

variable "eks_oidc_provider" {
  description = "EKS OIDC Provider"
  type        = string
  default     = ""
}

#--------------------------------------------------------------
# IAM OIDC Identity Provider
#--------------------------------------------------------------
variable "create_idp" {
  description = "Whether to create an IAM Cluster Identity Provider."
  type        = bool
  default     = true
}

variable "idp_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim."
  type        = string
  default     = ""
}

variable "client_id_list" {
  description = "A list of client IDs (also known as audiences)."
  type        = list(string)
  default = [
    "sts.amazonaws.com"
  ]
}

variable "thumbprint_list" {
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s). Default Thumbprint of Root CA for EKS OIDC, Valid until 2037."
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}


#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------
variable "create_iam_role" {
  description = "Whether to create the IAM Role"
  type        = bool
  default     = true
}

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "iam_path" {
  description = "If provided, all IAM roles will be created on this path."
  type        = string
  default     = "/"
}

variable "kubernetes_service_account" {
  description = "Service Account of N"
  type        = string
  default     = "nodejs-sa"
}

variable "kubernetes_namespace" {
  description = "Namespace of Node.js application"
  type        = string
  default     = "nodejs"
}

#--------------------------------------------------------------
# S3 Bucket
#--------------------------------------------------------------
variable "create_s3_bucket" {
  description = "Whether to create the IAM Role"
  type        = bool
  default     = true
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "The Name of the S3 bucket. Optional. If not provided, one will be created."
}

variable "noncurrent_version_expiration_days" {
  default     = "35"
  description = "S3 object versions expiration period (days)"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket"
  default     = "private"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = false
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = false
}

variable "force_destroy" {
  description = "Whether Terraform to force_destroy the S3 bucket on destroy."
  default     = false
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
}

variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ID used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
}

variable "versioning_enabled" {
  description = "Whether Amazon S3 should have versioning enabled for bucket."
  default     = true
}

variable "replication_configuration" {
  description = "Map containing cross-region replication configuration."
  type        = any
  default     = {}
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = [
    {
      id      = "twdc-s3-lifecycle"
      enabled = true
      prefix  = "/"
      transition = [
        {
          days          = 180
          storage_class = "STANDARD_IA"
        }
      ]
      noncurrent_version_expiration = {
        days = 35
      }
    }
  ]
}