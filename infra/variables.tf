variable "aws_region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags for AWS that will be attached to each resource."
  default = {
    "Environment"     = "Development",
    "DeployedBy"      = "Terraform",
    "OwnerEmail"      = "bugaenko.yu@gmail.com"
  }
}

variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
  default     = "django"
}

variable "profile" {
  type    = string
  default = "myprofile"
}

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