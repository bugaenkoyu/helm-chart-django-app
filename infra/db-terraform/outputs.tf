output "rds_endpoint" {
  description = "Endpoint for the RDS instance"
  value       = aws_db_instance.postgres_db.endpoint
}

