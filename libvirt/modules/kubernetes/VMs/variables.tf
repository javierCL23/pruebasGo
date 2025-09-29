
variable "vnc_id" {
  type        = string
  description = "ID de la VNC"
}

variable "volume_ids" {
  type        = map(string)
  description = "ID de los volúmenes para usar"
}

variable "pool_name" {
  type        = string
  description = "Nombre del pool en el que se almacenará el cloudinit"
}

variable "machine_specs" {
  description = "Especificaciones que asignar a cada una de las vms"
  type = map(object({
    cpu    = number # Número de CPUs
    memory = number # Memoria en MB
    disk   = number # Tamaño del disco en GB
  }))
  validation {
    condition     = contains(keys(var.machine_specs), "CP")
    error_message = "Debe existir una VM con nombre 'CP' en el mapa de VMs."
  }
}

variable "user_name" {
  type        = string
  description = "Nombre del usuario a usar en las máquinas"
}

variable "github_users" {
  type        = list(string)
  description = "Lista de usuarios de GitHub cuyos keys se añadirán"
}

