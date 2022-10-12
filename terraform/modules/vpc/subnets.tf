#terraform-ansible.terraform.modules.vpc['subnets']

locals {
  public_specs = ["a", "b", "c"]
  cidr_range   = 16
}

resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = format("10.0.%s.0/20", tostring(16 + (count.index * local.cidr_range)))
  availability_zone       = format("${var.region}%s", local.public_specs[count.index])
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "${var.name-prefix}-subnet-public-${var.initials}"
    IsPublic                                    = "true"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/elb:"                   = "1"
  }
}
