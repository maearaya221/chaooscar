terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name = "Infra"
}

module "subnets" {
  source = "../../modules/subnets"
  vpc_id = module.vpc.vpc_id
  name_prefix = "Infra"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet = ["10.0.11.0/24", "10.0.12.0/24"]
}

module "internet_gateway" {
  source = "../../modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet = module.subnets.public_subnet
  name_prefix = "Infra"
}

module "nat_gateway" {
  source = "../../modules/nat_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet = module.subnets.public_subnet[0]
  private_subnet = module.subnets.private_subnet
  name_prefix = "infra-nat"
}

module "security_group_linux" {
  source = "../../modules/security_group"
  name = "Infra_security"
  description = "Infra security group"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
  egress_rules = [
    {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
}

module "security_group_lb" {
  source = "../../modules/security_group"
  name = "Infra_security_lb"
  description = "Infra security group load balancer"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
  egress_rules = [
    {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
}

module "load_balancer" {
  source             = "../../modules/load_balancer"
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_group_lb.security_group_id]
  subnets            = [module.subnets.public_subnet[0], module.subnets.public_subnet[1]]
  tag_name           = "my-alb"
}

module "target_group" {
  source              = "../../modules/target_group"
  name                = "my-tg"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = module.vpc.vpc_id
  protocol_health     = "HTTP"
  path                = "/"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

module "listener" {
  source            = "../../modules/listener"
  load_balancer_arn = module.load_balancer.load_balancer_arn
  port              = 80
  protocol          = "HTTP"
  type              = "forward"
  target_group_arn  = module.target_group.target_group_arn
}

module "key" {
  source = "../../modules/key"
  key_name = "key_linux"
}

module "ami" {
  source = "../../modules/ami"
  name_prefix = "linux"
  instance_type = "t2.micro"
  key_name = module.key.key_name
  user_data = filebase64("${path.module}/script/init.sh")
  security_group_id = [module.security_group_linux.security_group_id]
  volume_size = 8
  public_ip = false
  volume_type = "gp3"
  delete = true
}

module "auto_scaling" {
  source = "../../modules/auto_scaling"
  name = "infraestructure"
  min_size = 2
  max_size = 2
  desired_capacity = 2
  plantilla_id = module.ami.ami_id
  launch_template_version = "$Latest"
  subnet_zone_id = [module.subnets.private_subnet[0], module.subnets.private_subnet[1]]
  target_group_arn = module.target_group.target_group_arn
}

output "dns_load_balancer" {
  value = module.load_balancer.dns_lb
}