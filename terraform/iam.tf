#----------------------------------------------------------------
# Node.js S3 Sample App IAM Role
#----------------------------------------------------------------

#--------------------------------------------------------------
# IAM Role Trust Policy
#--------------------------------------------------------------
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${local.aws_account_id}:oidc-provider/${var.eks_oidc_provider}"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_provider}:sub"
      values = [
        "system:serviceaccount:${var.kubernetes_namespace}:${var.kubernetes_service_account}"
      ]
    }
  }
}

#--------------------------------------------------------------
# IAM Role
#--------------------------------------------------------------
resource "aws_iam_role" "_" {
  count                 = var.create_iam_role ? 1 : 0
  name                  = "${var.cluster_name}-nodejs_s3"
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  permissions_boundary  = var.permissions_boundary
  path                  = var.iam_path
  force_detach_policies = true
}

#--------------------------------------------------------------
# IAM Role Policy Attachment
#--------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "_" {
  count      = var.create_iam_role ? 1 : 0
  policy_arn = aws_iam_policy._[0].arn
  role       = aws_iam_role._[0].name
}

#--------------------------------------------------------------
# IAM Role Policy
#--------------------------------------------------------------
resource "aws_iam_policy" "_" {
  count       = var.create_iam_role ? 1 : 0
  name_prefix = "${var.cluster_name}-nodejs-s3"
  description = "Node.js S3 IAM Policy for cluster ${var.cluster_name}"
  policy      = data.aws_iam_policy_document._.json
  path        = var.iam_path
}

#--------------------------------------------------------------
# IAM Role Policy Document
#--------------------------------------------------------------
data "aws_iam_policy_document" "_" {
  statement {
    sid    = "s3Permissions"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]
  }
}