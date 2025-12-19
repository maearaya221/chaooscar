output "amazon_linux_2023" {
  value = data.aws_ssm_parameter.amazon_linux_2023.value
}
output "ami_id" {
  value = aws_launch_template.template_linux.id
}