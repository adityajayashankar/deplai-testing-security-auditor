variable "project_name" {
  type    = string
  default = "deplai-testing-security-auditor"
}

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "enable_ec2" {
  type    = bool
  default = true
}

variable "existing_ec2_key_pair_name" {
  type    = string
  default = ""
}

variable "ingress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ssh_ingress_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "preferred_availability_zones" {
  type    = list(string)
  default = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}

variable "use_default_vpc" {
  type    = bool
  default = true
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.42.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.42.1.0/24"
}

variable "force_destroy_site_bucket" {
  type    = bool
  default = true
}

variable "ec2_root_volume_size" {
  type    = number
  default = 8
}

variable "bootstrap_index_html_base64" {
  type      = string
  default   = "PGh0bWw+CiAgPGhlYWQ+PHRpdGxlPkRlcGxBSSBEZXBsb3ltZW50PC90aXRsZT48L2hlYWQ+CiAgPGJvZHkgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgcGFkZGluZzogMnJlbTsiPgogICAgPGgxPkRlcGxBSSBkZXBsb3ltZW50IGlzIGxpdmU8L2gxPgogICAgPHA+UHJvamVjdDogZGVwbGFpLXRlc3Rpbmctc2VjdXJpdHktYXVkaXRvcjwvcD4KICAgIAogIDwvYm9keT4KPC9odG1sPg=="
  sensitive = true
}

variable "context_summary" {
  type    = string
  default = ""
}
