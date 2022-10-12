#terraform-ansible.modules.server['variables.tf']


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

# variable "cluster-name" {
#   description = "Name of EKS cluster. Declared and passed in through top-level main.tf."
#   type        = string
# }

variable "subnet_id" {
  type = string
}

variable "allow_ssh_sg_id" {
  type = string
}

