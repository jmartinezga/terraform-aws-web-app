###############################################################################
# Common variables
###############################################################################
locals {

  tf_version = trimspace(chomp(file("./tf_version")))

  tags = merge(var.tags, {
    terraform = "${local.tf_version}",
  })
}

###############################################################################
# VPC
###############################################################################
module "vpc" {
  source = "git@github.com:jmartinezga/terraform-aws-vpc.git?ref=devel"

  region         = var.region
  environment    = var.environment
  application    = var.application
  vpc_name       = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  tags           = local.tags
}

###############################################################################
# IAM Role - CodeDeployServiceRole
###############################################################################
module "codedeploy_role" {
  source = "git@github.com:jmartinezga/terraform-aws-iam-role.git?ref=devel"

  region           = var.region
  environment      = var.environment
  application      = var.application
  role_name        = "CodeDeloyServiceRole"
  role_description = "CodeDeploy Service Role"
  aws_service      = "codedeploy.amazonaws.com"
  role_policy_arns_list = [
    "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
  policy_name = "CodeDeployAutoScalingGroupLaunchTemplatePolicy"
  policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole",
          "ec2:CreateTags",
          "ec2:RunInstances"
        ],
        "Resource" : "*"
      }
    ]
  }
  tags = local.tags
}

###############################################################################
# IAM Role - InstanceRole
###############################################################################
module "instance_role" {
  source = "git@github.com:jmartinezga/terraform-aws-iam-role.git?ref=devel"

  region           = var.region
  environment      = var.environment
  application      = var.application
  role_name        = "EC2InstanceRole"
  role_description = "EC2 Instance Role"
  aws_service      = "ec2.amazonaws.com"
  role_policy_arns_list = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy",
  ]
  tags = local.tags
}

###############################################################################
# EC2 - Security Group (RDS Postgres)
###############################################################################
module "rds_sg" {
  source = "git@github.com:jmartinezga/terraform-aws-ec2-security-group.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  sg_name        = "postgres-sg"
  sg_description = "RDS Security Group"
  vpc_id         = module.vpc.id
  sg_ingress_rules_cidr = {
    "sg_rds" = {
      from_port   = 5432,
      to_port     = 5432,
      protocol    = "tcp",
      cidr_blocks = module.vpc.private_subnets_cidr,
      description = "VPC private subnets"
    }
  }
  sg_ingress_rules_source_sg = {}

  tags = local.tags

  depends_on = [
    module.vpc
  ]

}

###############################################################################
# RDS - Postgres
###############################################################################
module "rds" {
  source = "git@github.com:jmartinezga/terraform-aws-rds-postgres.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  rds_identifier     = "${var.application}-pg"
  rds_engine         = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_instance_class = var.rds_instance_class
  rds_user           = var.rds_user

  vpc_cidr                = module.vpc.cidr
  vpc_subnet_list         = module.vpc.private_subnets_id
  vpc_security_group_list = [module.rds_sg.id]

  tags = local.tags

  depends_on = [
    module.vpc,
    module.rds_sg
  ]
}

###############################################################################
# EC2 - Security Group (ALB)
###############################################################################
module "alb_sg" {
  source = "git@github.com:jmartinezga/terraform-aws-ec2-security-group.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  sg_name        = "alb-sg"
  sg_description = "ALB Security Group"
  vpc_id         = module.vpc.id

  sg_ingress_rules_cidr = {
    "http" = {
      from_port   = 80,
      to_port     = 80,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"],
      description = "http from Internet"
    }
  }
  sg_ingress_rules_source_sg = {}

  tags = local.tags

  depends_on = [
    module.vpc
  ]

}

###############################################################################
# EC2 - Application Load Balancer
###############################################################################
module "alb" {
  source = "git@github.com:jmartinezga/terraform-aws-ec2-load-balancer.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  lb_name                = "${var.application}-lb"
  lb_type                = "application"
  lb_internal            = false
  lb_security_group_list = [module.alb_sg.id]
  lb_subnets_list        = module.vpc.private_subnets_id
  lb_vpc_id              = module.vpc.id

  lb_health_check = var.lb_health_check

  tags = local.tags

  depends_on = [
    module.vpc,
    module.alb_sg
  ]
}

###############################################################################
# EC2 - Security Group
###############################################################################
module "ec2_sg" {
  source = "git@github.com:jmartinezga/terraform-aws-ec2-security-group.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  sg_name        = "ec2-sg"
  sg_description = "EC2 Security Group"
  vpc_id         = module.vpc.id

  sg_ingress_rules_cidr = {}
  sg_ingress_rules_source_sg = {
    "sg_alb" = {
      from_port                = var.ec2_sg_ingress_rule_from_port,
      to_port                  = var.ec2_sg_ingress_rule_to_port,
      protocol                 = var.ec2_sg_ingress_rule_protocol,
      source_security_group_id = module.alb_sg.id,
      description              = "Application Load Balancer"
    }
  }

  tags = local.tags

  depends_on = [
    module.vpc,
    module.alb_sg
  ]

}

###############################################################################
# EC2 - Autoscaling Group
###############################################################################
module "asg" {
  source = "git@github.com:jmartinezga/terraform-aws-ec2-autoscaling-group.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  asg_name               = "${var.application}-asg"
  ami_name               = var.ami_name
  ec2_key_pair           = var.ec2_key_pair
  asg_subnets_list       = module.vpc.private_subnets_id
  lc_security_group_list = [module.ec2_sg.id]
  lb_tg_arn              = module.alb.tg_arn

  depends_on = [
    module.vpc,
    module.alb,
    module.ec2_sg
  ]
}

###############################################################################
# CODEDEPLOY
###############################################################################
module "codedeploy" {
  source = "git@github.com:jmartinezga/terraform-aws-codedeploy.git?ref=devel"

  region      = var.region
  environment = var.environment
  application = var.application

  cd_app_name         = var.application
  cd_compute_platform = "Server"
  dg_service_role     = module.codedeploy_role.arn
  dg_asg_name         = [module.asg.name]
  dg_lb_tg_name       = module.alb.tg_name
  sns_email           = var.sns_email

  tags = local.tags

  depends_on = [
    module.codedeploy_role,
    module.asg,
    module.alb
  ]
}
