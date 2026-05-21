module "network" {
  source   = "./modules/network"
  app_port = var.app_port
  allowed_ip = var.allowed_ip
}

module "compute" {
  source               = "./modules/compute"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_id    = module.network.security_group_id
  iam_instance_profile = var.iam_profile
  
  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nodejs npm git

    # Crear directorio y entrar
    mkdir -p /home/ec2-user/app
    cd /home/ec2-user/app

    # Clonar tu repositorio (Cambia TU_USUARIO y TU_REPO)
    git clone https://github.com/rafael1199v/legacy-billing-test.git .

    # Instalar dependencias de Node
    npm install

    # Arrancar la aplicación en segundo plano
    nohup node app.js > /home/ec2-user/app/server.log 2>&1 &

    # Comentario dummy para forzar la recreacion en Terraform
  EOF
}