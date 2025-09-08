variable "app" {
  description = "Application Name"
  default     = ""
}

variable "env" {
  default = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = null
}

variable "public_subnet_ciders" {
  type    = list(string)
  default = []
}


variable "private_subnet_ciders" {
  type    = list(string)
  default = []
}

variable "db_subnet_ciders" {
  type    = list(string)
  default = []
}
