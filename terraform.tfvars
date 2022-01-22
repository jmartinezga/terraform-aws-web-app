###############################################################################
# Common variables
###############################################################################
region      = "eu-west-1"
environment = "dev"
application = "web-app"

###############################################################################
# VPC Module variables
###############################################################################
vpc_name       = "main"
vpc_cidr_block = "10.1.0.0/16"


###############################################################################
# RDS Module variables
###############################################################################
rds_engine         = "postgres"
rds_engine_version = "9.6.23"
rds_instance_class = "db.t2.micro"
rds_user           = "postgres"

###############################################################################
# EC2_SG Module variables
###############################################################################
ec2_sg_ingress_rule_from_port = 8000
ec2_sg_ingress_rule_to_port   = 8000
ec2_sg_ingress_rule_protocol  = "tcp"

###############################################################################
# ASG Module variables
###############################################################################
ami_name     = "golden-ami"
ec2_key_pair = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkSgRJCgVNDxg3EOZfM6kiIb+nUwM4GfNtBjuDyEowgm8et3xt2a/e7eAVtv/ZHJuFO9XZQEqVT/LZ2vTAiBOLTlsfS/7ERYY0H8yzJVrsxSEiMprZqO+Pk3gvt8xenkZWXM0q2NtCR+ZfLO91UuW9V/PAvZqgBTLkvIEr53l7vWvtcTlrz0Q/5b+yLHIfYjueLZpHOP8fzCpV6MwKZ8A9U3S+i4jl658zIZBjj7j+Tct9H5Z8t6fZ0Z9yPSM2dwVxNWrFre07/hmaevX87meJi8bapVt09k6qGW8UQAsWvGBSBtX5TtfQOUXCpfRbHDciOnj7GC5d780RBhSp9N1Y3On7djYTCLdo2te5qLVRmOmh/eMzo3mnhq2uveUtGglnf8DQ8ENX2tSsMOpn1niY33hZHth+ZJgle0cNILCjBOPs66a+a7tqncZlWjOsXQer95tcqUnhQLKn+zMPdbCkUHdNfm/dsvKqFqOj6v7jvXMqFkzBSnmoTyaa0TzELBc= jordi@desktop"

###############################################################################
# CodeDeploy Module variables
###############################################################################
sns_email = "jmartinez.galvez@gamil.com"
