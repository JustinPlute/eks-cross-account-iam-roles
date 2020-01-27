
#--------------------------------------------------------------
# IAM OpenID Connect Provider
# https://www.terraform.io/docs/providers/aws/r/iam_openid_connect_provider.html

# The Root CA Thumbprint for an OpenID Connect Identity Provider is currently
# Being passed as a default value which is the same for all regions and
# Is valid until (Jun 28 17:39:16 2034 GMT).
# https://crt.sh/?q=9E99A48A9960B14926BB7F3B02E22DA2B0AB7280
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
# https://github.com/terraform-providers/terraform-provider-aws/issues/10104
#--------------------------------------------------------------

resource "aws_iam_openid_connect_provider" "_" {
  count           = var.create_idp ? 1 : 0
  url             = var.idp_url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list
}