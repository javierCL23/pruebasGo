variable "cluster_name" {
  type        = string
  description = "Nombre del clúster K8s (Se usará para nombrar el pool con los volúmenes)"
}

variable "volumes_path" {
  type        = string
  description = "Path en el que se almacenarán los distintos volúmenes de la máquina"
}

variable "iso_path" {
  type        = string
  description = "Path a la imagen a usar en las máquinas"
}


variable "machine_specs" {
  description = "Especificaciones que asignar a cada una de las vms"
  type = map(object({
    cpu    = number # Número de CPUs
    memory = number # Memoria en MB
    disk   = number # Tamaño del disco en GB
    ip     = string # IP estática a asignar a la máquina
  }))
  validation {
    condition     = contains(keys(var.machine_specs), "CP")
    error_message = "Debe existir una VM con nombre 'CP' en el mapa de VMs."
  }
}

variable "vnc_id" {
  type        = string
  description = "ID de la VNC creada"
}

variable "github_users" {
  description = "Lista de usuarios de GitHub cuyos keys se añadirán"
  type        = list(string)
  default     = ["jcarreno2312", "otro_usuario"]
}

variable "user_name" {
  type        = string
  description = "Nombre de usuario de las máquinas"
}


#Kubernetes config
variable "worker_scripts"{
  description = "Lista con los paths de scripts que debe de ejecutar el worker"
  type        = list(string)
}

variable "cp_scripts" {
  description = "Lista con los paths de scripts que debe ejecutar el CP"
  type        = list(string)
}

variable "private_key"{
  description = "path a la SSH key privada para conectarse a las máquinas"
  type = string
}
