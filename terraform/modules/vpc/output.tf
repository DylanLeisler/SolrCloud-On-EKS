#terraform-ansible.terraform.modules.vpc['output.tf']

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public
}

output "allow_ssh_sg_id" {
  value = aws_security_group.allow_ssh.id
}
