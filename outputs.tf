output "master_username" {
  description = "Username for the master DB user."
  sensitive   = true
  value       = try(aws_docdb_cluster.this.master_username, null)
}

output "master_password" {
  description = "password for the master DB user."
  sensitive   = true
  value       = length(var.master_password) == 0 ? random_password.master[0].result : var.master_password
}

output "cluster_name" {
  description = "Cluster Identifier."
  value       = try(aws_docdb_cluster.this.cluster_identifier, null)
}

output "arn" {
  value       = try(aws_docdb_cluster.this.arn, null)
  description = "Amazon Resource Name (ARN) of the cluster."
}

output "writer_endpoint" {
  description = "Endpoint of the DocumentDB cluster."
  value       = try(aws_docdb_cluster.this.endpoint, null)
}

output "reader_endpoint" {
  description = "A read-only endpoint of the DocumentDB cluster, automatically load-balanced across replicas."
  value       = try(aws_docdb_cluster.this.reader_endpoint, null)
}
