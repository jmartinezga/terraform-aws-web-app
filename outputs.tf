#https://www.terraform.io/language/values/outputs
###############################################################################
# VPC
###############################################################################
output "vpc_arn" {
  description = "VPC arn."
  value       = module.vpc.arn
}

output "vpc_id" {
  description = "VPC Id."
  value       = module.vpc.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc.cidr
}

output "vpc_private_subnets_id" {
  description = "VPC private subnets"
  value       = module.vpc.private_subnets_id
}

output "vpc_private_subnets_cidr" {
  description = "VPC private subnets CIDR"
  value       = module.vpc.private_subnets_cidr
}
output "vpc_public_subnets_id" {
  description = "VPC public subnets"
  value       = module.vpc.public_subnets_id
}

output "vpc_public_subnets_cidr" {
  description = "VPC public subnets CIDR"
  value       = module.vpc.public_subnets_cidr
}

###############################################################################
# IAM Roles
###############################################################################
output "codedeploy_role_name" {
  description = "Role name"
  value       = module.codedeploy_role.name
}

output "codedeploy_role_arn" {
  description = "Role arn"
  value       = module.codedeploy_role.arn
}

output "instance_role_name" {
  description = "Role name"
  value       = module.instance_role.name
}

output "instance_role_arn" {
  description = "Role arn"
  value       = module.instance_role.arn
}

###############################################################################
# EC2 - Security Group (RDS Postgres)
###############################################################################
output "rds_sg_id" {
  description = "RDS (Postgres) Security Group id."
  value       = module.rds_sg.id
}

output "rds_sg_arn" {
  description = "RDS (Postgres) Security Group arn."
  value       = module.rds_sg.arn
}

###############################################################################
# RDS - Postgres
###############################################################################
output "rds_endpoint" {
  description = "RDS (Postgres) Endpoint."
  value       = module.rds.endpoint
}

output "rds_address" {
  description = "RDS Postgres) Address."
  value       = module.rds.address
}

###############################################################################
# EC2 - Security Group (ALB)
###############################################################################
output "alb_sg_id" {
  description = "ALB Security Group id."
  value       = module.alb_sg.id
}

output "alb_sg_arn" {
  description = "ALB Security Group arn."
  value       = module.alb_sg.arn
}

###############################################################################
# ALB
###############################################################################
output "alb_id" {
  description = "Application Load Balancer id."
  value       = module.alb.id
}

output "alb_arn" {
  description = "Application Load Balancer arn."
  value       = module.alb.arn
}
output "tg_id" {
  description = "Target group id."
  value       = module.alb.tg_id
}

output "tg_arn" {
  description = "Target group arn."
  value       = module.alb.tg_arn
}

###############################################################################
# EC2 - Security Group
###############################################################################
output "ec2_sg_id" {
  description = "EC2 Security Group id."
  value       = module.ec2_sg.id
}

output "ec2_sg_arn" {
  description = "EC2 Security Group arn."
  value       = module.ec2_sg.arn
}

###############################################################################
# ASG
###############################################################################
output "asg_id" {
  description = "Autoscaling Group id."
  value       = module.asg.id
}

output "asg_arn" {
  description = "Autoscaling Group arn."
  value       = module.asg.arn
}

output "asg_name" {
  description = "Autoscaling Group name."
  value       = module.asg.name
}

###############################################################################
# CodeDeploy
###############################################################################
output "codedeploy_arn" {
  description = "CodeDeploy arn."
  value       = module.codedeploy.arn
}

output "codedeploy_application_id" {
  description = "CodeDeploy Application id."
  value       = module.codedeploy.application_id
}
