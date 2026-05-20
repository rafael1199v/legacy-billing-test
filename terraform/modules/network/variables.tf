variable "app_port" {
  description = "Puerto por donde escucha la app"
  type        = number
}

variable "allowed_ip" {
  description = "IP permitida para acceder al servidor"
  type        = string
}