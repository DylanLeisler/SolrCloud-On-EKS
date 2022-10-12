#terraform-ansible.terraform.modules.vpc['security-groups.tf']


resource "aws_security_group" "allow_all_traffic" {
  name        = "allow-all-traffic"
  description = "Allows all traffic --inbound and outbound"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "All inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name     = "allow-all-traffic"
    Initials = var.initials
    MadeWith = var.name-prefix
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allows SSH traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name     = "allow-ssh"
    Initials = var.initials
    MadeWith = var.name-prefix
  }
}
