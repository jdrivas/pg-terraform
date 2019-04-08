
variable "password" {
  description = "Database master password. Should be provided through environment or local_variables files or command line. NOT IN SCC"
}

variable "component_name" {
  default = "rds postges"
  description = "Component in stack (e.g. measurements-db)"
}

variable "env" {
  default = "development"
  description = "Deployment environment (e.g. staging, production)"
}

variable "region" {
  default = "us-west-1"
  description = "AWS Regition to instance the database"
}

variable "storage" {
  default = "10"
  description = "Storage size in GB"
}

variable "instance_class" {
  default = ""
  description = "EC2 Instance type to use for database"
}

variable "multi_az" {
  default = true
  description = "Set up a multi-az standby for failover"
}

variable "postgres_version" {
  default = "11.1"
  description = "Version of postgres to instance"
}

variable "username" {
  default = "postgres"
  description = "Master user name for database"
}

variable "db_subgroup_name" {
  default = ""
  description = "Leave blank to assign a terraform generated unique name"
}

variable "vpc_id" {
  default = ""
  description = "The RDS instances attaches to this VPC, leave blank to use the default VPC"
}

variable "db_subnet_ids" {
  default = []
  description = "Subnets to attach to, this can't be left blank."
}


variable "ingress_cidr_blocks" {
  default = ["0.0.0.0/0"] 
  description = "Used to restrict access to specific IP addresses, defaults to full internet"
}

variable "monitoring_interval" {
  default = 0
  description = "0 means no monitoring; valud values are: 0, 1, 5, 10, 15 30, 60"
}

variable "backup_retention_period"{
  default = 30
  description = "Between 0 35, number of days to keep backups - 0 is no backup"
}

variable "storage_encrypted" {
  default = false
  description = "Set to true if you want an encrypted database"
}

variable "cloudwatch_exports" {
  default = []
  # default =  ["alert", "audit", "error", "general", "listener", "slowquery", "trace", "postgresql", "upgrade"]
  description = "List of logs to export to cloudwatch, needs a group ARN to work."
}

