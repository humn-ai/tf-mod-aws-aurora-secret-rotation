<!-- 














  ** DO NOT EDIT THIS FILE
  ** 
  ** This file was automatically generated by the `build-harness`. 
  ** 1) Make all changes to `README.yaml` 
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file. 
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **















  -->

#

[![README Header][logo]][website]

# tf-mod-aws-mysql-secret-rotation

## Module description


Use the `tf-mod-aws-mysql-secret-rotation` module to create all the resources to store and rotate a MySQL or Aurora password using the AWS Secrets Manager service.






## Introduction

The `tf-mod-aws-rds` module will create:
* A RDS MySQL Database Secret stored in AWS Secrets Manager
* An AWS Lambda function with permission to rotate the MySQL secret (VPC & non-VPC enabled)
* The IAM roles and policies to asoociate and grant access for the Lambda function to call the AWS Secrets Manager & KMS Services
* An AWS CloudWatch log group for the associated Lambda Function

## Pattern

![Pattern](https://raw.githubusercontent.com/giuseppeborgese/terraform-aws-secret-manager-with-rotation/master/schema.jpg)



## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/https://github.com/Callumccr/tf-mod-aws-mysql-secret-rotation/releases).


The below values shown in the usage of this module are purely representative, please replace desired values as required.

```hcl

```





## Examples
Simple and advanced examples of this project.

### Advanced Example 1:

TO-DO

  ```hcl
  ```


## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| availability\_zones | (Required) - The AWS avaialbility zones (e.g. ap-southeast-2a/b/c). Autoloaded from region.tfvars. | `list(string)` | n/a | yes |
| alias | (Optional) - The display name of the alias. The name must start with the word `alias` followed by a forward slash | `string` | `"alias/secrets"` | no |
| attributes | (Optional) - Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| automatically\_after\_days | (Required) Specifies the number of days between automatic scheduled rotations of the secret | `number` | `30` | no |
| aws\_account\_id | The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | (Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_assume\_role\_external\_id | (Optional) - The external ID to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_assume\_role\_session\_name | (Optional) - The session name to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_region | The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| deletion\_window\_in\_days | (Optional) - Duration in days after which the key is deleted after destruction of the resource | `number` | `10` | no |
| delimiter | (Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| description | (Optional) - The description of the key as viewed in AWS console | `string` | `"Parameter Store KMS master key"` | no |
| enable\_key\_rotation | (Optional) - Specifies whether key rotation is enabled | `bool` | `true` | no |
| enabled | (Optional) -  A Switch that decides whether to create a terraform resource or run a provisioner. Default is true | `bool` | `true` | no |
| environment | (Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod' | `string` | `""` | no |
| filename | (Optional) - The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options cannot be used. | `string` | `""` | no |
| name | (Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline' | `string` | `""` | no |
| namespace | (Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core' | `string` | `""` | no |
| policy | (Optional) - A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. | `string` | `""` | no |
| recovery\_window\_in\_days | (Optional) Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30. | `number` | `0` | no |
| secret\_config | (Optional) A list of objects that contain RDS information including `username`, `password`, `port`, `hostname`, and 'arn' to create lambda rotation | <code><pre>object({<br>    engine               = string<br>    host                 = string<br>    username             = string<br>    password             = string<br>    dbname               = string<br>    port                 = string<br>    dbInstanceIdentifier = string<br>  })<br></pre></code> | <code><pre>{<br>  "dbInstanceIdentifier": "",<br>  "dbname": "",<br>  "engine": "mysql",<br>  "host": "",<br>  "password": "",<br>  "port": "3306",<br>  "username": "root"<br>}<br></pre></code> | no |
| security\_group\_ids | (Optional) - List of Security Group IDs that are allowed ingress to the Lambda function | `list(string)` | `[]` | no |
| subnet\_ids | (Required) - A list of subnet IDs associated with the Lambda function. | `list(string)` | `[]` | no |
| tags | (Optional) - Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias\_arn | Alias ARN |
| alias\_name | Alias name |
| key\_arn | Key ARN |
| key\_id | Key ID |
| lambda\_arn | The ARN of the Lambda function |
| lambda\_ids | The name of the VPC Lambda functions |
| role\_arn | The ARN of the IAM role created for the Lambda function |
| role\_name | The name of the IAM role created for the Lambda function |
| secret\_id | Amazon Resource Name (ARN) of the secret. |




## Related Projects

You can find more [Terraform Modules](terraform_modules) by vising the link.

Additionally, check out these other related, and maintained projects.

- [%!s(<nil>)](%!s(<nil>)) - %!s(<nil>)



## References

For additional context, refer to some of these links. 

- [Databases with Fully Configured and Ready-to-Use Rotation Support](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html#full-rotation-support) - Reference AWS Documentation for this module
- [AWS RDS MySQL Single User Pattern](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_available-rotation-templates.html#sar-template-mysql-singleuser) - Reference AWS Documentation for this module



## Help

**Got a question?** We got answers. 

File a Github [issue](https://github.com/Callumccr/tf-mod-aws-mysql-secret-rotation/issues), or message us on [Slack][slack]


### Contributors

|  [![Callum Robertson][callumccr_avatar]][callumccr_homepage]<br/>[Callum Robertson][callumccr_homepage] |
|---|


  [callumccr_homepage]: https://www.linkedin.com/in/callum-robertson-1a55b6110/

  [callumccr_avatar]: https://media-exp1.licdn.com/dms/image/C5603AQHb_3oZMZA5YA/profile-displayphoto-shrink_200_200/0?e=1588809600&v=beta&t=5QQQAlHrm1od5fQNZwdjOtbZWvsGcgNBqFRhZWgnPx4




---



---


[![README Footer][logo]][website]

  [logo]: https://wariva-github-assets.s3.eu-west-2.amazonaws.com/logo.png
  [website]: https://www.linkedin.com/company/52152765/admin/
  [github]: https://github.com/Callumccr
  [slack]: https://wariva.slack.com
  [linkedin]: https://www.linkedin.com/in/callum-robertson-1a55b6110/
  [terraform_modules]: https://github.com/Callumccr