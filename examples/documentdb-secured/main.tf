provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source     = "git::https://github.com/opszero/terraform-aws-vpc.git?ref=v1.0.1"
  name       = "test"
  cidr_block = "10.0.0.0/16"
}

module "subnet" {
  source             = "git::https://github.com/opszero/terraform-aws-subnets.git?ref=v1.0.0"
  name               = "app"
  environment        = "test"
  availability_zones = ["eu-west-1a", "eu-west-1b", ]
  type               = "public"
  vpc_id             = module.vpc.vpc_id
  cidr_block         = module.vpc.vpc_cidr_block
  igw_id             = module.vpc.igw_id
  enable_ipv6        = true
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

module "documentdb" {
  source = "../../"
  name   = "documentdb"


  vpc_id            = module.vpc.vpc_id
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [27017]

  subnet_list             = module.subnet.public_subnet_id
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = var.storage_encrypted
  instance_class          = var.instance_class
  cluster_family          = "docdb5.0"
  cluster_size            = var.cluster_size
  deletion_protection     = true
  preferred_backup_window = "07:00-07:30"
  ca_cert_identifier      = "rds-ca-rsa2048-g1"
  parameters = [
    {
      apply_method = "immediate"
      name         = "tls"
      value        = "enabled"
    }
  ]
}