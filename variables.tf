#https://www.terraform.io/language/values/variables
variable "vpc_name" {
  description = "(Required) VPC name."
  type        = string

  validation {
    condition     = length(var.vpc_name) > 0
    error_message = "VPC name is required."
  }
}

variable "vpc_cidr_block" {
  description = "(Required) The IPv4 CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(regex("\\d{1,3}[.]{1}\\d{1,3}[.]{1}\\d{1,3}[.]{1}\\d{1,3}[/]{1}(8|16)", var.vpc_cidr_block))
    error_message = "VPC name is required."
  }
}

variable "ec2_key_pair" {
  description = "(Required) EC2 key pair."
  type        = string

  validation {
    condition     = can(regex("^ssh-rsa.*", var.ec2_key_pair))
    error_message = "EC2 key pair is required."
  }
}

variable "rds_engine" {
  description = "(Required) RDS Engine"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.rds_engine) > 0
    error_message = "RDS Engine is required (ex: postgres)."
  }
}

variable "rds_engine_version" {
  description = "(Required) RDS Engine version"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.rds_engine_version) > 0
    error_message = "RDS Engine version is required (ex: 9.6)."
  }
}

variable "rds_instance_class" {
  description = "(Required) RDS Instance class"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.rds_instance_class) > 0
    error_message = "RDS Instance class is required (ex: db.t2.micro)."
  }
}

variable "rds_user" {
  description = "(Required) RDS user name"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.rds_user) > 0
    error_message = "RDS user name is required."
  }
}

variable "lb_health_check" {
  description = "(Optional) Load Balancer Health check."
  type = object({
    path                = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    matcher             = string
  })
  default = {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}
variable "ec2_sg_ingress_rule_from_port" {
  description = "(Required) Security Group ingress rule from port."
  type        = number

  validation {
    condition     = var.ec2_sg_ingress_rule_from_port < 65536
    error_message = "EC2 Security Group ingress rule from port has to be a valid port number."
  }
}

variable "ec2_sg_ingress_rule_to_port" {
  description = "(Required) EC2 Security Group ingress rule to port."
  type        = number

  validation {
    condition     = var.ec2_sg_ingress_rule_to_port < 65536
    error_message = "EC2 Security Group ingress rule to port has to be a valid port number."
  }
}

variable "ec2_sg_ingress_rule_protocol" {
  description = "(Required) EC2 Security Group protocol."
  type        = string

  validation {
    condition     = can(regex("tcp|udp", var.ec2_sg_ingress_rule_protocol))
    error_message = "EC2 Security Group protocol has to be a valid protocol."
  }
}
variable "ami_name" {
  description = "(Required) AMI Name."
  type        = string

  validation {
    condition     = length(var.ami_name) > 0
    error_message = "AMI name is required."
  }
}
variable "sns_email" {
  description = "(Required) SNS Topic Subscription email."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("[a-zA-Z0-9-_.+]*@[a-zA-Z0-9.]*[.]{1}[a-z]{3}", var.sns_email))
    error_message = "You must put a valid email address (ex: codedeploy_notifications@company.com)."
  }
}

###############################################################################
# OPTIONAL
###############################################################################
variable "vpc_instance_tenacy" {
  description = "(Optional) A tenancy option for instances launched into the VPC. Defaults 'default'."
  type        = string
  default     = "default"
}

variable "vpc_enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
  default     = true
}
variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) Tags to assign to the resource."
  type        = any
  default     = {}
}
