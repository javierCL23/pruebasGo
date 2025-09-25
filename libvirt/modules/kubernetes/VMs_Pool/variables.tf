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

variable "names" {
  type        = list(string)
  description = "Lista con los nombres de todas las VM que se van a crear"
}

variable "disk_sizes" {
  type        = list(number)
  description = "Lista con los tamaños de cada volumen para cada máquina"
}
