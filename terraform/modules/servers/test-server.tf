#terraform-ansible.terraform.modules.server['test-server.tf']


resource "aws_instance" "test-instance" {
  ami           = "ami-0d5bf08bc8017c83b"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  associate_public_ip_address = true

  key_name               = "test-key"
  vpc_security_group_ids = [var.allow_ssh_sg_id]

  tags = {
    Name = "test-instance"
  }
}
