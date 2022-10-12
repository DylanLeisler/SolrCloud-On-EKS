#!/bin/bash


SERVER=$(terraform output -json | jq .server_public_dns.value -r)

KEY="../ssh-symlink/test-key.pem"
USER=ubuntu
PORT=22

ssh -i $KEY -l $USER -p $PORT $SERVER
