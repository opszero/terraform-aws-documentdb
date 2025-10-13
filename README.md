# Terraform-aws-documentdb

# Terraform AWS Cloud DocumentDB Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#Examples)
- [Author](#Author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This Terraform module creates an AWS documentdb along with additional configuration options.
## Usage
To use this module, you can include it in your Terraform configuration. Here's an example of how to use it:

## Examples

## Example: documentdb-secured

```hcl
module "documentdb-secured" {
  source            = "git::https://github.com/opszero/terraform-aws-documentdb.git.git?ref=v1.0.1"
  name              = "documentdb"
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
```

## Example: documentdb-simple

```hcl
module "documentdb-simple" {
  source            = "git::https://github.com/opszero/terraform-aws-documentdb.git.git?ref=v1.0.1"
  name              = "dev"

  vpc_id            = module.vpc.vpc_id
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [27017]

  subnet_list         = module.subnet.public_subnet_id
  master_username     = "test"
  master_password     = var.master_password
  instance_class      = var.instance_class
  cluster_size        = var.cluster_size
  deletion_protection = false
}
```

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/opszero/terraform-aws-documentdb/tree/main/examples) directory within this repository.

## Author
Your Name Replace **MIT** and **opsZero** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the **MIT** License - see the [LICENSE](https://github.com/opszero/terraform-aws-documentdb/blob/main/LICENSE) file for details.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.14.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.7.2 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip"></a> [allowed\_ip](#input\_allowed\_ip) | List of allowed ip. | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | List of allowed ingress ports | `list(any)` | <pre>[<br>  80,<br>  443<br>]</pre> | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. | `bool` | `true` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the certificate authority (CA) certificate for the DB instance. | `string` | `null` | no |
| <a name="input_cluster_family"></a> [cluster\_family](#input\_cluster\_family) | The family of the DocumentDB cluster parameter group. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html . | `string` | `"docdb5.0"` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of DB instances to create in the cluster | `string` | `"2"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | (optional) describe your variable | `bool` | `null` | no |
| <a name="input_egress_ipv4_cidr_block"></a> [egress\_ipv4\_cidr\_block](#input\_egress\_ipv4\_cidr\_block) | List of CIDR blocks. Cannot be specified with source\_security\_group\_id or self. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv4_from_port"></a> [egress\_ipv4\_from\_port](#input\_egress\_ipv4\_from\_port) | Egress Start port (or ICMP type number if protocol is icmp or icmpv6). | `number` | `0` | no |
| <a name="input_egress_ipv4_protocol"></a> [egress\_ipv4\_protocol](#input\_egress\_ipv4\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_ipv4_to_port"></a> [egress\_ipv4\_to\_port](#input\_egress\_ipv4\_to\_port) | Egress end port (or ICMP code if protocol is icmp). | `number` | `65535` | no |
| <a name="input_egress_ipv6_cidr_block"></a> [egress\_ipv6\_cidr\_block](#input\_egress\_ipv6\_cidr\_block) | List of CIDR blocks. Cannot be specified with source\_security\_group\_id or self. | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_from_port"></a> [egress\_ipv6\_from\_port](#input\_egress\_ipv6\_from\_port) | Egress Start port (or ICMP type number if protocol is icmp or icmpv6). | `number` | `0` | no |
| <a name="input_egress_ipv6_protocol"></a> [egress\_ipv6\_protocol](#input\_egress\_ipv6\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_ipv6_to_port"></a> [egress\_ipv6\_to\_port](#input\_egress\_ipv6\_to\_port) | Egress end port (or ICMP code if protocol is icmp). | `number` | `65535` | no |
| <a name="input_egress_rule"></a> [egress\_rule](#input\_egress\_rule) | Enable to create egress rule | `bool` | `true` | no |
| <a name="input_enable_security_group"></a> [enable\_security\_group](#input\_enable\_security\_group) | Enable default Security Group with only Egress traffic allowed. | `bool` | `true` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery. | `list(string)` | <pre>[<br>  "audit",<br>  "profiler"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb`. | `string` | `"docdb"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version number of the database engine to use. | `string` | `""` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs . | `string` | `"db.t3.medium"` | no |
| <a name="input_is_external"></a> [is\_external](#input\_is\_external) | enable to udated existing security Group | `bool` | `false` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | (Required unless a snapshot\_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. | `string` | `""` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | (Required unless a snapshot\_identifier is provided) Username for the master DB user. | `string` | `"root"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the database. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DocumentDB parameters to apply. Setting parameters to system default values may show a difference on imported resources. | <pre>list(object({<br>    apply_method = optional(string)<br>    name         = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | Daily time range during which the backups happen. | `string` | `"07:00-09:00"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Number of days to retain backups for. | `string` | `"7"` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| <a name="input_sg_egress_description"></a> [sg\_egress\_description](#input\_sg\_egress\_description) | Description of the egress and ingress rule | `string` | `"Description of the rule."` | no |
| <a name="input_sg_egress_ipv6_description"></a> [sg\_egress\_ipv6\_description](#input\_sg\_egress\_ipv6\_description) | Description of the egress\_ipv6 rule | `string` | `"Description of the rule."` | no |
| <a name="input_sg_ids"></a> [sg\_ids](#input\_sg\_ids) | of the security group id. | `list(any)` | `[]` | no |
| <a name="input_sg_ingress_description"></a> [sg\_ingress\_description](#input\_sg\_ingress\_description) | Description of the ingress rule | `string` | `"Description of the ingress rule use elasticache."` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted. | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. | `string` | `""` | no |
| <a name="input_ssh_allowed_ip"></a> [ssh\_allowed\_ip](#input\_ssh\_allowed\_ip) | List of allowed ip. | `list(any)` | `[]` | no |
| <a name="input_ssh_allowed_ports"></a> [ssh\_allowed\_ports](#input\_ssh\_allowed\_ports) | List of allowed ingress ports | `list(any)` | `[]` | no |
| <a name="input_ssh_protocol"></a> [ssh\_protocol](#input\_ssh\_protocol) | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| <a name="input_ssh_sg_ingress_description"></a> [ssh\_sg\_ingress\_description](#input\_ssh\_sg\_ingress\_description) | Description of the ingress rule | `string` | `"Description of the ingress rule use elasticache."` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. | `bool` | `true` | no |
| <a name="input_subnet_list"></a> [subnet\_list](#input\_subnet\_list) | List of subnet IDs database instances should deploy into. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |
## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the cluster. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster Identifier. |
| <a name="output_master_password"></a> [master\_password](#output\_master\_password) | password for the master DB user. |
| <a name="output_master_username"></a> [master\_username](#output\_master\_username) | Username for the master DB user. |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | A read-only endpoint of the DocumentDB cluster, automatically load-balanced across replicas. |
| <a name="output_writer_endpoint"></a> [writer\_endpoint](#output\_writer\_endpoint) | Endpoint of the DocumentDB cluster. |
# 🚀 Built by opsZero!

<a href="https://opszero.com"><img src="https://opszero.com/wp-content/uploads/2024/07/opsZero_logo_svg.svg" width="300px"/></a>

Since 2016 [opsZero](https://opszero.com) has been providing Kubernetes
expertise to companies of all sizes on any Cloud. With a focus on AI and
Compliance we can say we seen it all whether SOC2, HIPAA, PCI-DSS, ITAR,
FedRAMP, CMMC we have you and your customers covered.

We provide support to organizations in the following ways:

- [Modernize or Migrate to Kubernetes](https://opszero.com/solutions/modernization/)
- [Cloud Infrastructure with Kubernetes on AWS, Azure, Google Cloud, or Bare Metal](https://opszero.com/solutions/cloud-infrastructure/)
- [Building AI and Data Pipelines on Kubernetes](https://opszero.com/solutions/ai/)
- [Optimizing Existing Kubernetes Workloads](https://opszero.com/solutions/optimized-workloads/)

We do this with a high-touch support model where you:

- Get access to us on Slack, Microsoft Teams or Email
- Get 24/7 coverage of your infrastructure
- Get an accelerated migration to Kubernetes

Please [schedule a call](https://calendly.com/opszero-llc/discovery) if you need support.

<br/><br/>

<div style="display: block">
  <img src="https://opszero.com/wp-content/uploads/2024/07/aws-advanced.png" width="150px" />
  <img src="https://opszero.com/wp-content/uploads/2024/07/AWS-public-sector.png" width="150px" />
  <img src="https://opszero.com/wp-content/uploads/2024/07/AWS-eks.png" width="150px" />
</div>
<!-- END_TF_DOCS -->