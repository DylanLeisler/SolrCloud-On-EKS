#terraform-ansible.modules.vpc['variables.tf']


variable "initials" {
  description = "Creator's initials"
  type        = string
  default     = "no-initials"
}

variable "region" {
  description = "Region to create VPC in."
  type        = string
}

variable "name-prefix" {
  description = "Prefix that will be appended to vpc and to named objects within."
  type        = string
  default     = "tf"
}

variable "cluster-name" {
  description = "Name of EKS cluster to share with subnets"
  type        = string
  default     = "test-cluster-name"
}

# variable "public_subnet_availability_zones" {
#   description = "Availability zones that will house public subnets."
#   type = list(string)
#   default = ["f", "e", "d"]
# }


