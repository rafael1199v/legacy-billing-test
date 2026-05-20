module "network" {
  source   = "./modules/network"
  app_port = var.app_port
}

module "compute" {
  source               = "./modules/compute"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_id    = module.network.security_group_id
  iam_instance_profile = var.iam_profile
  
  user_data = <<-EOF
    #!/bin/bash
    # Actualizar sistema
    dnf update -y
    # Instalar Node.js y utilidades
    dnf install -y nodejs npm git unzip
    
    # Preparar el directorio para el Hito 3
    mkdir -p /home/ec2-user/app
    chown -R ec2-user:ec2-user /home/ec2-user/app
  EOF
}