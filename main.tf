provider "aws" {
    region  = "us-east-2"    
}
terraform {
  backend "s3" {
    bucket = "impalla215.bucket"
    key    = "c:/terraform-vpc/terraform.tfstate"
    region = "us-east-2"
    
  }

}

module "vpc" {
  source            = "./modules/vpc"
}

module "elb" {
  source                = "./modules/elb"
  ec2_instance_id       = module.ec2.instance_id
  private_subnet_a_id   = module.vpc.subnet_id
  public_subnet_b_id    = module.vpc.subnet_id_b
  vpc_security_group_id = module.vpc.security_group_id
  aws_vpc = module.vpc.aws_vpc
}

module "ec2" {
  source                = "./modules/ec2"
  private_subnet_a_id   = module.vpc.subnet_id
  vpc_security_group_id = module.vpc.security_group_id
}
###testovoe izmenenie