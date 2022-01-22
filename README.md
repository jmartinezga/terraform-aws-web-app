# Terraform Web App Infrastructure

### Install dependencies

<!-- markdownlint-disable no-inline-html -->

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/terraform-docs/terraform-docs)
* [`terragrunt`](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* [`terrascan`](https://github.com/accurics/terrascan)
* [`TFLint`](https://github.com/terraform-linters/tflint)
* [`TFSec`](https://github.com/liamg/tfsec)
* [`infracost`](https://github.com/infracost/infracost)
* [`jq`](https://github.com/stedolan/jq)

### Install the pre-commit hook globally

```bash
DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | git@github.com:jmartinezga/terraform-aws-ec2-load-balancer.git | devel |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | git@github.com:jmartinezga/terraform-aws-ec2-security-group.git | devel |
| <a name="module_asg"></a> [asg](#module\_asg) | git@github.com:jmartinezga/terraform-aws-ec2-autoscaling-group.git | devel |
| <a name="module_codedeploy"></a> [codedeploy](#module\_codedeploy) | git@github.com:jmartinezga/terraform-aws-codedeploy.git | devel |
| <a name="module_codedeploy_role"></a> [codedeploy\_role](#module\_codedeploy\_role) | git@github.com:jmartinezga/terraform-aws-iam-role.git | devel |
| <a name="module_ec2_sg"></a> [ec2\_sg](#module\_ec2\_sg) | git@github.com:jmartinezga/terraform-aws-ec2-security-group.git | devel |
| <a name="module_instance_role"></a> [instance\_role](#module\_instance\_role) | git@github.com:jmartinezga/terraform-aws-iam-role.git | devel |
| <a name="module_rds"></a> [rds](#module\_rds) | git@github.com:jmartinezga/terraform-aws-rds-postgres.git | devel |
| <a name="module_rds_sg"></a> [rds\_sg](#module\_rds\_sg) | git@github.com:jmartinezga/terraform-aws-ec2-security-group.git | devel |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git@github.com:jmartinezga/terraform-aws-vpc.git | devel |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | (Required) AMI Name. | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | (Required) Application name | `string` | n/a | yes |
| <a name="input_ec2_key_pair"></a> [ec2\_key\_pair](#input\_ec2\_key\_pair) | (Required) EC2 key pair. | `string` | n/a | yes |
| <a name="input_ec2_sg_ingress_rule_from_port"></a> [ec2\_sg\_ingress\_rule\_from\_port](#input\_ec2\_sg\_ingress\_rule\_from\_port) | (Required) Security Group ingress rule from port. | `number` | n/a | yes |
| <a name="input_ec2_sg_ingress_rule_protocol"></a> [ec2\_sg\_ingress\_rule\_protocol](#input\_ec2\_sg\_ingress\_rule\_protocol) | (Required) EC2 Security Group protocol. | `string` | n/a | yes |
| <a name="input_ec2_sg_ingress_rule_to_port"></a> [ec2\_sg\_ingress\_rule\_to\_port](#input\_ec2\_sg\_ingress\_rule\_to\_port) | (Required) EC2 Security Group ingress rule to port. | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment (dev, stg, prd) | `string` | n/a | yes |
| <a name="input_lb_health_check"></a> [lb\_health\_check](#input\_lb\_health\_check) | (Optional) Load Balancer Health check. | <pre>object({<br>    path                = string<br>    healthy_threshold   = number<br>    unhealthy_threshold = number<br>    timeout             = number<br>    interval            = number<br>    matcher             = string<br>  })</pre> | <pre>{<br>  "healthy_threshold": 5,<br>  "interval": 30,<br>  "matcher": "200",<br>  "path": "/",<br>  "timeout": 5,<br>  "unhealthy_threshold": 2<br>}</pre> | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | (Required) RDS Engine | `string` | n/a | yes |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | (Required) RDS Engine version | `string` | n/a | yes |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | (Required) RDS Instance class | `string` | n/a | yes |
| <a name="input_rds_user"></a> [rds\_user](#input\_rds\_user) | (Required) RDS user name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS Region | `string` | n/a | yes |
| <a name="input_sns_email"></a> [sns\_email](#input\_sns\_email) | (Required) SNS Topic Subscription email. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to the resource. | `any` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | (Required) The IPv4 CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#input\_vpc\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. | `bool` | `false` | no |
| <a name="input_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#input\_vpc\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true. | `bool` | `true` | no |
| <a name="input_vpc_instance_tenacy"></a> [vpc\_instance\_tenacy](#input\_vpc\_instance\_tenacy) | (Optional) A tenancy option for instances launched into the VPC. Defaults 'default'. | `string` | `"default"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | (Required) VPC name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | Application Load Balancer arn. |
| <a name="output_alb_id"></a> [alb\_id](#output\_alb\_id) | Application Load Balancer id. |
| <a name="output_alb_sg_arn"></a> [alb\_sg\_arn](#output\_alb\_sg\_arn) | ALB Security Group arn. |
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | ALB Security Group id. |
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | Autoscaling Group arn. |
| <a name="output_asg_id"></a> [asg\_id](#output\_asg\_id) | Autoscaling Group id. |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Autoscaling Group name. |
| <a name="output_codedeploy_application_id"></a> [codedeploy\_application\_id](#output\_codedeploy\_application\_id) | CodeDeploy Application id. |
| <a name="output_codedeploy_arn"></a> [codedeploy\_arn](#output\_codedeploy\_arn) | CodeDeploy arn. |
| <a name="output_codedeploy_role_arn"></a> [codedeploy\_role\_arn](#output\_codedeploy\_role\_arn) | Role arn |
| <a name="output_codedeploy_role_name"></a> [codedeploy\_role\_name](#output\_codedeploy\_role\_name) | Role name |
| <a name="output_ec2_sg_arn"></a> [ec2\_sg\_arn](#output\_ec2\_sg\_arn) | EC2 Security Group arn. |
| <a name="output_ec2_sg_id"></a> [ec2\_sg\_id](#output\_ec2\_sg\_id) | EC2 Security Group id. |
| <a name="output_instance_role_arn"></a> [instance\_role\_arn](#output\_instance\_role\_arn) | Role arn |
| <a name="output_instance_role_name"></a> [instance\_role\_name](#output\_instance\_role\_name) | Role name |
| <a name="output_rds_address"></a> [rds\_address](#output\_rds\_address) | RDS Postgres) Address. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | RDS (Postgres) Endpoint. |
| <a name="output_rds_sg_arn"></a> [rds\_sg\_arn](#output\_rds\_sg\_arn) | RDS (Postgres) Security Group arn. |
| <a name="output_rds_sg_id"></a> [rds\_sg\_id](#output\_rds\_sg\_id) | RDS (Postgres) Security Group id. |
| <a name="output_tg_arn"></a> [tg\_arn](#output\_tg\_arn) | Target group arn. |
| <a name="output_tg_id"></a> [tg\_id](#output\_tg\_id) | Target group id. |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | VPC arn. |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | VPC CIDR |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC Id. |
| <a name="output_vpc_private_subnets_cidr"></a> [vpc\_private\_subnets\_cidr](#output\_vpc\_private\_subnets\_cidr) | VPC private subnets CIDR |
| <a name="output_vpc_private_subnets_id"></a> [vpc\_private\_subnets\_id](#output\_vpc\_private\_subnets\_id) | VPC private subnets |
| <a name="output_vpc_public_subnets_cidr"></a> [vpc\_public\_subnets\_cidr](#output\_vpc\_public\_subnets\_cidr) | VPC public subnets CIDR |
| <a name="output_vpc_public_subnets_id"></a> [vpc\_public\_subnets\_id](#output\_vpc\_public\_subnets\_id) | VPC public subnets |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
