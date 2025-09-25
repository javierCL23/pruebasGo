variable "vnc_name" {
  type        = string
  description = "Nombre de la red VNC a crear"
}

variable "domain" {
  type        = string
  description = "Dominio usado por el servidor de DNS"
}

variable "vnc_range" {
  type        = string
  description = "Rango CIDR para la VCN (ejemplo: 10.20.0.0/16)"
}
