###################### VPC Module #################################
module "vpc" {
  source = "../../modules/vpc"
  env    = "qa"
}

###################### ALB Module ################################
module "alb" {
  source  = "../../modules/alb"
  env     = "qa"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_id

}
###################### ASG Module ##############################

module "asg" {
  source              = "../../modules/asg"
  env                 = "qa"
  vpc_id              = module.vpc.vpc_id
  vpc_zone_identifier = module.vpc.private_subnet_id
  lb_target_group_arn = module.alb.target_group_arn
}
