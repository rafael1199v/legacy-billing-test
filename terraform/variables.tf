variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "Puerto de la aplicación Node.js"
  type        = number
  default     = 3000
}

variable "ami_id" {
  description = "AMI de Amazon Linux 2023"
  type        = string
  default     = "ami-0c101f26f147fa7fd" 
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.micro" 
}

variable "iam_profile" {
  description = "Perfil IAM para la instancia (ej: LabInstanceProfile)"
  type        = string
  default     = "LabInstanceProfile" 
}