#terraform-ansible.terraform.modules.vpc['routing.tf']


resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name-prefix}-ig-${var.initials}"
  }
}



resource "aws_route_table" "rt_ig" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.name-prefix}-rt-ig-${var.initials}"
  }

  depends_on = [aws_internet_gateway.ig]
}


resource "aws_main_route_table_association" "main_route_association" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.rt_ig.id
}
