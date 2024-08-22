variable "name" {
  description = "Name of the database."
  type        = string
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "kms_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the kms is enabled or disabled."
}

variable "kms_multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "kms_description" {
  type        = string
  default     = "KMS key for documentdb"
  description = "The description of the key as viewed in AWS console."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  sensitive   = true
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported."
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource."
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled."
}

variable "enable_key_rotation" {
  type        = string
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  sensitive   = true
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
}

variable "alias" {
  type        = string
  default     = "alias/ec2-test"
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."
}

variable "vpc_id" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The ID of the VPC that the instance security group belongs to."
}

variable "allowed_ip" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "List of allowed ip."
}

variable "allowed_ports" {
  type        = list(any)
  default     = [80, 443]
  description = "List of allowed ingress ports"
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "egress_rule" {
  type        = bool
  default     = true
  description = "Enable to create egress rule"
}

variable "is_external" {
  type        = bool
  default     = false
  description = "enable to udated existing security Group"
}

variable "sg_ids" {
  type        = list(any)
  default     = []
  description = "of the security group id."
}

variable "sg_description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}
variable "sg_egress_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress and ingress rule"
}

variable "sg_egress_ipv6_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress_ipv6 rule"
}

variable "sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use elasticache."
  description = "Description of the ingress rule"
}

variable "ssh_allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "ssh_allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "ssh_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "ssh_sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use elasticache."
  description = "Description of the ingress rule"
}

variable "egress_ipv4_from_port" {
  type        = number
  default     = 0
  description = "Egress Start port (or ICMP type number if protocol is icmp or icmpv6)."
}

variable "egress_ipv4_to_port" {
  type        = number
  default     = 65535
  description = "Egress end port (or ICMP code if protocol is icmp)."
}

variable "egress_ipv4_protocol" {
  type        = string
  default     = "-1"
  description = "Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
}

variable "egress_ipv4_cidr_block" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = " List of CIDR blocks. Cannot be specified with source_security_group_id or self."
}

variable "egress_ipv6_from_port" {
  type        = number
  default     = 0
  description = "Egress Start port (or ICMP type number if protocol is icmp or icmpv6)."
}

variable "egress_ipv6_to_port" {
  type        = number
  default     = 65535
  description = "Egress end port (or ICMP code if protocol is icmp)."
}

variable "egress_ipv6_protocol" {
  type        = string
  default     = "-1"
  description = "Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
}

variable "egress_ipv6_cidr_block" {
  type        = list(string)
  default     = ["::/0"]
  description = " List of CIDR blocks. Cannot be specified with source_security_group_id or self."
}


variable "master_password" {
  type        = string
  default     = ""
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
}



variable "master_username" {
  type        = string
  default     = "root"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user."
}

variable "retention_period" {
  type        = string
  default     = "7"
  description = "Number of days to retain backups for."
}

variable "preferred_backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "Daily time range during which the backups happen."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
}

variable "subnet_list" {
  type        = list(string)
  default     = [""]
  description = "List of subnet IDs database instances should deploy into."
}

variable "cluster_family" {
  type        = string
  default     = "docdb5.0"
  description = "The family of the DocumentDB cluster parameter group. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html ."
}

variable "engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb`."
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The version number of the database engine to use."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["audit", "profiler"]
  description = "List of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery."
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs ."
}

variable "cluster_size" {
  type        = string
  default     = "2"
  description = "Number of DB instances to create in the cluster"
}

variable "ca_cert_identifier" {
  type        = string
  default     = null
  description = "The identifier of the certificate authority (CA) certificate for the DB instance."
}

variable "parameters" {
  type = list(object({
    apply_method = optional(string)
    name         = string
    value        = string
  }))
  default     = []
  description = "A list of DocumentDB parameters to apply. Setting parameters to system default values may show a difference on imported resources."
}

variable "deletion_protection" {
  type        = bool
  default     = null
  description = "(optional) describe your variable"
}
