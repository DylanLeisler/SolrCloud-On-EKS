#terraform['output.tf']


output "server_public_dns" {
  value = module.servers.server_public_dns
}
