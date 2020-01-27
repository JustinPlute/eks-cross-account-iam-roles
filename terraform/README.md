# Terraform Module

This demo Terraform Module provisions the following AWS resources:

* Cross-Account IAM Role for Node.js application
* Cross-Account IAM OIDC Identity Provider
* Cross-Account S3 Bucket for an Node.js application

## Deploy

```
module "iam_resources" {
  source       = "JustinPlute/eks-cross-account-iam-roles//terraform"
  
  bucket_name = "my-bucket"
  
  idp_url = "https://oidc.eks.region.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D30413"

  eks_oidc_provider = "oidc.eks.region.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D30413"
  kubernetes_namespace = "nodejs"
  kubernetes_service_account = "nodejs-sa"

  create_iam_role = true
  create_idp = true
  create_s3_bucket = true
}
```

