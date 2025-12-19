output "key_name" {
  value = aws_key_pair.key.key_name
}

output "private_key_pem" {
  value = tls_private_key.tls.private_key_pem
    sensitive = true
}

output "pem_file_path" {
  value = local_file.pem_file.filename
}
