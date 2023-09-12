variable "cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
  # default = "10.0.0.0/16"
}

variable "vpc_name" {
  # type = int
  # default = "vpc"

}

variable "igw_name" {
  # default = "igw"
}