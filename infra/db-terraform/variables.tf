variable "profile" {
  type    = string
  default = "myprofile"
}

variable "region" {
  default = "eu-central-1"
  type = string
  description = "The region where I want to deploy the infrastructure in"
}

variable "namespace" {
  description = "Namespace for resource names"
  default     = "task7"
  type        = string
}

variable "project" {
  description = "Project name for tags"
  default     = "k8s"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "EKS"
  type        = string
}

#variable "vpc_cidr_block" {
#  description = "CIDR block for the VPC network"
#  default     = "10.1.0.0/16"
#  type        = string
#}
#
#variable "az_count" {
#  description = "Describes how many availability zones are used"
#  default     = 2
#  type        = number
#}

# rds

variable "rds_db_name" {
  description = "RDS database name"
  default     = "django_db"
}
variable "rds_username" {
  description = "RDS database username"
  default     = "django_aws"
}
variable "rds_password" {
  description = "postgres password for production DB"
}
variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t3.micro"
}


