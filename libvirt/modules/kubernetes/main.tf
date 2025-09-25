terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

module "VMs_Pool" {
  source       = "./VMs_Pool"
  cluster_name = var.cluster_name
  volumes_path = var.volumes_path
  iso_path     = var.iso_path
  disk_sizes   = [for spec in values(var.machine_specs) : spec.disk]
  names        = keys(var.machine_specs)
}


module "VMs" {
  source        = "./VMs"
  machine_specs = var.machine_specs
  pool_name     = module.VMs_Pool.all_outputs.pool.name
  volume_ids    = module.VMs_Pool.volume_ids
  vnc_id        = var.vnc_id
  github_users  = var.github_users
  user_name     = var.user_name
  depends_on    = [module.VMs_Pool]
}


module "Kubernetes_config" {
  source = "./kubernetes_config"
  machines = module.VMs.machines
  worker_scripts = var.worker_scripts
  cp_scripts = var.cp_scripts
  cp_ip    = module.VMs.all_outputs.CP.ip
  cp_user  = module.VMs.all_outputs.CP.user
  private_key = var.private_key
  depends_on = [module.VMs]
}  


