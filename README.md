# EKS Cross-Account IAM Roles

This repository is the source code for the following blog article, [Cross-Account IAM Roles on Amazon EKS](https://medium.com/@justinplute/cross-account-iam-roles-on-amazon-eks-d2922d77ab8f).

**List of different Project Components:**

* A **Node.js Dockerized Application** illustrating usage of the [AWS SDK](https://aws.amazon.com/sdk-for-node-js/) for [Node.js](https://nodejs.org/en/). This application will interact with an [S3 Bucket](https://aws.amazon.com/s3/) in another AWS account, **AWS Account B**.
* A **Helm Chart (v3)** that deploys the Node.js Dockerized Application to an [Amazon EKS Cluster](https://aws.amazon.com/eks/) in **AWS Account A**.
* **Terraform Resources** that will create an [IAM OIDC Identity Provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html), [IAM Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html), and [S3 Bucket](https://aws.amazon.com/s3/) in **AWS Account B**. Once provisioned, the Node.js Dockerized Application will be able to assume the Cross-Account IAM Role and interact with the S3 Bucket in **AWS Account B**.

## Prequisites

I assume you already have an Amazon EKS cluster provisioned in your AWS account. If not, I recommend taking a look at this [EKS Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-eks).

You will also need at least version `1.16.232` of the AWS CLI. Moreover, the IAM roles for service accounts feature is available only on new Amazon EKS Kubernetes version 1.14 clusters, and clusters that were updated to versions 1.14 or 1.13 on or after September 3rd, 2019.

## Contributing

Please [create a new GitHub issue](https://github.com/JustinPlute/eks-cross-account-iam-roles/issues/new) for any feature requests, bugs, or documentation improvements.

Where possible, please also [submit a pull request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/) for the change.

## License

This sample application is distributed under the [MIT License](https://opensource.org/licenses/MIT).
