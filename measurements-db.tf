

variable "password" {
  description = "Database master password. Should be provided through environment or local_variables files or command line. NOT IN SCC"
}

module "postgres" {
  source =  "./modules/rds/postgres" 
  password = "${var.password}"
  component_name = "measurements-db"
  env = "production"
  region = "us-west-1"
  storage = 1200
  instance_class = "db.m5.2xlarge"
  ingress_cidr_blocks = ["12.252.204.14/32", "73.71.31.249/32"]
  vpc_id = "vpc-05fbc661"
  db_subnet_ids = ["subnet-67ae7600", "subnet-69846a32"]
  # backup_retention_period = 0  # 0 goes a bit faster as it doesn't do an initial backup - not for real production delopy.
}

