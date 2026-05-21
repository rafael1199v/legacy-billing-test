resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data

  user_data_replace_on_change = true

  tags = {
    Name = "Servidor-Legacy-Billing"
  }
}