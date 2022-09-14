

########### VPC Module
module "vpc" {
    source = "./modules/vpc"
    aws_creds = var.aws_creds
    owner = var.owner
    region = var.region
    base_name = var.base_name
    vpc_cidr = var.vpc_cidr
    subnet_cidr_blocks = var.subnet_cidr_blocks
    subnet_azs = var.subnet_azs
}


output "subnet-ids" {
  value = module.vpc.subnet-ids
}

output "vpc-id" {
  value = module.vpc.vpc-id
}

# ########### Node Module
# module "vpc" {
#     source = "./modules/vpc"
#     aws_creds = var.aws_creds
#     owner = var.owner
#     region = var.region
#     base_name = var.base_name
#     vpc_cidr = var.vpc_cidr
#     subnet_cidr_blocks = var.subnet_cidr_blocks
#     subnet_azs = var.subnet_azs
# }