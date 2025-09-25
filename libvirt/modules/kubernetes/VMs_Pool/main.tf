terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

resource "libvirt_pool" "VMs_Pool" {
  name = var.cluster_name
  type = "dir"
  target {
    path = var.volumes_path
  }
}


resource "libvirt_volume" "base_image" {
  name   = "ubuntu-base.qcow2"
  pool   = libvirt_pool.VMs_Pool.name
  source = var.iso_path
  format = "qcow2"
}

resource "libvirt_volume" "VMs_Volumes" {
  for_each = { for idx, name in var.names : name => var.disk_sizes[idx] }

  name   = "${each.key}.qcow2"
  pool   = libvirt_pool.VMs_Pool.name
  base_volume_id = libvirt_volume.base_image.id
  size   = each.value
  format = "qcow2"
}
