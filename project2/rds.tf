#RDS Multi-AZ

resource "aws_db_subnet_group" "main" {
  name       = "ha-webapp-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "ha-webapp-db-subnet-group"
  }
}

resource "random_password" "rds_password" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "project2-rds-password"
  recovery_window_in_days = 0 #delete secret immediately instead of putting on sof-delete state for 30 days
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.rds_password.result
}

resource "aws_db_instance" "main" {
  identifier             = "ha-webapp-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "webappdb"
  username               = "admin"
  password               = random_password.rds_password.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  multi_az               = true
  publicly_accessible    = false
  deletion_protection    = false
  skip_final_snapshot    = true

  tags = {
    Name = "ha-webapp-db"
  }
}