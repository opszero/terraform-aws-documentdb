
provider "aws" {
  region = "us-east-1"
}


module "documentdb" {
  source      = "../../"
  enable      = true
  name        = "documentdb"
  environment = "test"
  label_order = ["environment", "name"]

  vpc_id            = "XXXXXXXXXXXXXXX"
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [27017]

  subnet_list             = "XXXXXXXXXXXXXX"
  database_name           = "test"
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