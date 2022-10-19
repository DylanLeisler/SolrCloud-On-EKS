#terraform.modules.deployments['variables.tf']

variable "initials" {
  description = "Initials of creator"
  type        = string
  default     = "DL"
}

variable "region" {
  description = "Region being used for infrastructure."
  type        = string
  default     = "us-east-2"

  validation {
    condition     = contains(["us-east-2"], var.region)
    error_message = "Invalid region entered."
  }
}

variable "name-prefix" {
  description = "Prefix to be appended to all objects made by this instance of terraform"
  type        = string
  default     = "tf"
}

variable "cluster_name" {
  description = "Name of EKS cluster for deployments"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint of EKS cluster. Used for deployments."
  type        = string
}

variable "cluster_cert" {
  description = "Cluster certification for controlling deployments."
  type        = string
}


variable "sc-name-ebs" {
  description = "Name of the EBS distributing storage class"
  type        = string
  default     = "ebs-standard"
}
