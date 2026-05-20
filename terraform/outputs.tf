output "ip_publica_servidor" {
  description = "La IP pública para acceder a la aplicación"
  value       = module.compute.public_ip
}