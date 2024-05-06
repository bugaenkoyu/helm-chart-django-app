resource "aws_db_subnet_group" "postgres" {
  name       = "postgres"
  subnet_ids = ["subnet-0466845f9e331e971", "subnet-06ea3ebe44623176e"]  //change
}

resource "aws_db_instance" "postgres_db" {
  identifier              = "postgres-db"
  db_name                 = var.rds_db_name
  username                = var.rds_username
  password                = var.rds_password
  port                    = "5432"
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = var.rds_instance_class
  allocated_storage       = "20"
  storage_encrypted       = false
  vpc_security_group_ids  = [aws_security_group.postgres_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.postgres.name
  multi_az                = false
  storage_type            = "gp2"
  publicly_accessible     = false
  backup_retention_period = 5
  skip_final_snapshot     = true
}

# RDS Security Group (traffic ECS -> RDS)
resource "aws_security_group" "postgres_sg" {
  name        = "rds-postgres"
  vpc_id      = "vpc-05be99919c30eb2dc"   //change

  tags = {
    Name = "PostgreSQL-Security-Group"
  }

  ingress {
    protocol        = "tcp"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = ["sg-03d43a3321f156b3d"]  //change
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}