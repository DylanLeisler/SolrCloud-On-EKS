#terraform.modules.servers['output.tf']

output "server_public_dns" {
  value = aws_instance.test-instance.public_dns
}
