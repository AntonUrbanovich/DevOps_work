provider "aws" {
    region  = "us-east-2"    
}
module "vpc"{
  source = "./modules/vpc"
}

module "ecs"{
  source = "./modules/ecs"
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  target_group_alb      = module.alb.target_group
}

module "alb"{
  source                = "./modules/alb"
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  vpc_for_alb           = module.vpc.aws_vpc
  public_subnet_a       = module.vpc.subnet_id_a

}
