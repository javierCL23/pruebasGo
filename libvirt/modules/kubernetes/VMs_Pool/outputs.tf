output "volume_ids" {
  description = "Mapa de nombre de VM a volumen_id"
  value       = { for name, vol in libvirt_volume.VMs_Volumes : name => vol.id }
}

output "all_outputs" {
  description = "Información del pool y de los volúmenes creados"
  value = {
    pool = {
      name = libvirt_pool.VMs_Pool.name
      path = var.volumes_path
    }

    volumes = {
      for name, vol in libvirt_volume.VMs_Volumes : name => {
        name   = vol.name
        size   = try(vol.size, null)
        format = try(vol.format, null)
        path   = try(vol.filename, null)
      }
    }
  }
}
