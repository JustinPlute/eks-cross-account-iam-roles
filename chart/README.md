# Node.js S3 Sample Helm Chart

This is a sample Helm 3 Chart, demonstrating passing annotations of an IAM Role to the Kubernetes Service Account definition.

## Required Helm Chart Values

```yaml
serviceAccount:
  name: nodejs-sa
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::AWS_ACCOUNT_B_ID:role/nodejs-s3-role

extraEnv:
 - name: S3_BUCKET_NAME
   value: 'some value'
```

## Deploy Helm Chart using Helmfile

[Helmfile](https://github.com/roboll/helmfile) is a great project to manage Helm Chart deployments. It provides a great abstraction and configuration capabilities when deploying a chart. A neat feature of Helmfile is having the capability to provide the Chart values via Environment Variables.

Example HelmFile:

```yaml
# helmfile.yaml
releases:
- name: nodejs-app
  namespace: nodejs
  chart: "./chart"
  version: "1.0.0"
  installed: true
  values:
    - serviceAccount:
        name: nodejs-sa
        annotations:
          eks.amazonaws.com/role-arn: '{{ env "IAM_ROLE_NAME" | default "arn:aws:iam::111111111111:role/nodejs-s3" }}' 
      extraEnv:
      - name: S3_BUCKET_NAME
        value: '{{ env "S3_BUCKET_NAME" | default "111111111111-us-west-2-nodejs-s3" }}' 
```

And with this, we can deploy to our EKS cluster with the following command:

```bash
$ helmfile sync
```