data "aws_ssm_parameter" "amazon_linux_2023" {
    name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "template_linux" {
  name_prefix = "linux_2023"
  image_id = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = var.user_data
  block_device_mappings {
    device_name = "/dev/xvda"

  ebs {
    volume_size = var.volume_size
    volume_type = var.volume_type
    delete_on_termination = var.delete
  }
  }

  network_interfaces {
    associate_public_ip_address = var.public_ip
    security_groups = var.security_group_id
  }

  tags = {
    Name = var.name_prefix
  }
}