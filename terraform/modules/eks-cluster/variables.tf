variable "initials" {
  description = "Creator's initials"
  type        = string
  default     = "no-initials"
}

variable "region" {
  description = "VPC's region."
  type        = string
}

variable "name-prefix" {
  description = "Prefix that will be appended to all project objects with formal 'names'."
  type        = string
  default     = "tf"
}

variable "cluster-name" {
  description = "Name of EKS cluster. Declared and passed in through top-level modules.tf."
  type        = string
}

variable "vpc_id" {
  description = "ID for the housing VPC"
  type        = string
}
