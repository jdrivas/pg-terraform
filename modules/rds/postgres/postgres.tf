

provider "aws" {
  region = "${var.region}"
}

locals  {
  identifier = "${var.component_name}-${var.env}"
}

resource "aws_security_group" "default" {
  description = "Allow Postgres only inbound traffic"
  vpc_id = "${var.vpc_id}" 

  ingress { # Restricted Postgres DB only traffic
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = "${var.ingress_cidr_blocks}"
  }
  
  egress { # All traffic
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG Postgres DB Only" 
  }
}

resource "aws_db_subnet_group" "default" {
  # name_prefix = "${var.identifier}"
  name_prefix = "${local.identifier}"
  subnet_ids = "${var.db_subnet_ids}"
}

resource "aws_db_instance" "default" {
  depends_on = ["aws_security_group.default", "aws_db_subnet_group.default"]  
  # identifier = "${var.identifier}"
  identifier = "${local.identifier}"
  allocated_storage = "${var.storage}"
  engine = "postgres"
  engine_version = "${var.postgres_version}"
  instance_class = "${var.instance_class}"
  username = "${var.username}"
  password = "${var.password}"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  apply_immediately = true
  backup_retention_period = "${var.backup_retention_period}"
  final_snapshot_identifier = "${local.identifier}-final-snapshot" # TODO: This is not unique on multiple destroys fo the same database name
  # deletion_protection = true   # TODO: Consider setting this. Deletion can't occur until this is set to false.
  enabled_cloudwatch_logs_exports = "${var.cloudwatch_exports}"
  monitoring_interval = "${var.monitoring_interval}"
  storage_encrypted = "${var.storage_encrypted}"
}
