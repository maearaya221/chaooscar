resource "tls_private_key" "tls" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "key" {
  key_name = var.key_name
  public_key = tls_private_key.tls.public_key_openssh
}

resource "local_file" "pem_file" {
  content = tls_private_key.tls.private_key_pem
  filename = "${path.module}/../../key/${var.key_name}.pem"
  file_permission = "0600"
}