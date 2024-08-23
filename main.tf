locals {
  name = lower(format("%v", var.name))
  tags = var.tags
}

resource "aws_security_group" "default" {
  count       = var.enable_security_group && length(var.sg_ids) < 1 ? 1 : 0
  name        = var.name
  vpc_id      = var.vpc_id
  description = var.sg_description
  tags        = local.tags
  lifecycle {
    create_before_destroy = true
  }
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "egress_ipv4" {
  count             = (var.enable_security_group && length(var.sg_ids) < 1 && var.is_external == false && var.egress_rule) ? 1 : 0
  description       = var.sg_egress_description
  type              = "egress"
  from_port         = var.egress_ipv4_from_port
  to_port           = var.egress_ipv4_to_port
  protocol          = var.egress_ipv4_protocol
  cidr_blocks       = var.egress_ipv4_cidr_block
  security_group_id = join("", aws_security_group.default[*].id)
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "egress_ipv6" {
  count             = var.enable_security_group && length(var.sg_ids) < 1 && var.is_external == false && var.egress_rule ? 1 : 0
  description       = var.sg_egress_ipv6_description
  type              = "egress"
  from_port         = var.egress_ipv6_from_port
  to_port           = var.egress_ipv6_to_port
  protocol          = var.egress_ipv6_protocol
  ipv6_cidr_blocks  = var.egress_ipv6_cidr_block
  security_group_id = join("", aws_security_group.default[*].id)
}

#tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "ssh_ingress" {
  count             = length(var.ssh_allowed_ip) > 0 && length(var.sg_ids) < 1 ? length(compact(var.ssh_allowed_ports)) : 0
  description       = var.ssh_sg_ingress_description
  type              = "ingress"
  from_port         = element(var.ssh_allowed_ports, count.index)
  to_port           = element(var.ssh_allowed_ports, count.index)
  protocol          = var.ssh_protocol
  cidr_blocks       = var.ssh_allowed_ip
  security_group_id = join("", aws_security_group.default[*].id)
}

#tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "ingress" {
  count = length(var.allowed_ip) > 0 && length(var.sg_ids) < 1 ? length(compact(var.allowed_ports)) : 0

  description       = var.sg_ingress_description
  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  cidr_blocks       = var.allowed_ip
  security_group_id = join("", aws_security_group.default[*].id)
}



data "aws_iam_policy_document" "kms" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

}

resource "random_password" "master" {
  count   = length(var.master_password) == 0 ? 1 : 0
  length  = 15
  special = false
}

resource "aws_docdb_cluster_parameter_group" "this" {
  name        = var.name
  description = "DB cluster parameter group."
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = local.tags
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier              = var.name
  master_username                 = var.master_username
  master_password                 = length(var.master_password) == 0 ? random_password.master[0].result : var.master_password
  backup_retention_period         = var.retention_period
  preferred_backup_window         = var.preferred_backup_window
  final_snapshot_identifier       = lower(var.name)
  skip_final_snapshot             = var.skip_final_snapshot
  apply_immediately               = var.apply_immediately
  deletion_protection             = var.deletion_protection
  storage_encrypted               = true
  snapshot_identifier             = var.snapshot_identifier
  vpc_security_group_ids          = length(var.sg_ids) < 1 ? aws_security_group.default[*].id : var.sg_ids
  db_subnet_group_name            = aws_docdb_subnet_group.this.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = local.tags

  depends_on = [aws_docdb_cluster_parameter_group.this]
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.cluster_size
  identifier         = "${var.name}-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.this[0].id
  apply_immediately  = var.apply_immediately
  instance_class     = var.instance_class
  tags               = local.tags
  engine             = var.engine
  ca_cert_identifier = var.ca_cert_identifier
}

resource "aws_docdb_subnet_group" "this" {
  name        = var.name
  description = "Allowed subnets for DB cluster instances."
  subnet_ids  = var.subnet_list
  tags        = local.tags
}
