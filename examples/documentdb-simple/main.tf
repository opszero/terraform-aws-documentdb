provider "aws" {
  region = "us-east-1"
}


module "documentdb" {
  source      = "../../"
  enable      = true
  environment = "dev"
  label_order = ["environment", "name"]

  vpc_id            = "XXXXXXXXXXXXXX"
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [27017]

  subnet_list         = "XXXXXXXXXXXXXXXXXXXX"
  database_name       = "test-db"
  master_username     = "test"
  master_password     = var.master_password
  instance_class      = var.instance_class
  cluster_size        = var.cluster_size
  deletion_protection = false
}