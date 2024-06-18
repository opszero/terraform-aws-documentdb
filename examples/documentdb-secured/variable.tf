variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the DB cluster is encrypted."
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs ."
}

variable "cluster_size" {
  type        = string
  default     = "1"
  description = "Number of DB instances to create in the cluster"
}