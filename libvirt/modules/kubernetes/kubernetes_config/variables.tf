variable "machines" { 
  description = "Información de todas las VMs"
  type = map(object({
    id       : string
    name     : string
    memory   : number
    vcpu     : number
    ip       : string
    user     : string
    gh_users : string
  }))
}

variable "worker_scripts"{
  description = "Lista con los paths de scripts que debe de ejecutar cada worker"
  type        = list(string)
}

variable "cp_scripts" {
  description = "Lista con los paths de scripts que debe ejecutar el CP"
  type        = list(string)
}

variable "cp_ip"{
  description = "IP del CP"
  type = string
}

variable "cp_user"{
  description = "Nombre del usuario de CP"
  type = string
}

variable "private_key"{
  description = "path a la SSH key privada para conectarse a las máquinas"
  type = string
}
