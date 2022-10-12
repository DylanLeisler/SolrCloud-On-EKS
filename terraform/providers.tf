

provider "aws" {
  region = var.region # Optional parameter. Will use AWS_DEFAULT_REGION env if this is not provided.
  default_tags {
    tags = {
      terraform = ""
      Initials  = var.initials
    }
  }
}
