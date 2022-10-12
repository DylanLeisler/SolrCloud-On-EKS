
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
