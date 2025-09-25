#=====================
#= Libvirt Terraform =
#=====================

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}



provider "libvirt" {
  uri = "qemu:///session"
}

#=====================
#=        VNC        =
#=====================

module "networking" {
  source    = "./modules/networking"
  vnc_name  = var.vnc_name
  vnc_range = var.vnc_range
  domain    = var.domain
}


#=====================
#=    K8s Cluster    =
#=====================

module "kubernetes" {
  source        = "./modules/kubernetes"
  cluster_name  = var.cluster_name
  volumes_path  = var.volumes_path
  machine_specs = var.machine_specs
  iso_path      = var.iso_path
  vnc_id        = module.networking.net_id
  github_users  = var.github_users
  user_name     = var.user_name

  worker_scripts = var.worker_scripts
  cp_scripts     = var.cp_scripts
  private_key    = var.private_key
  depends_on    = [module.networking]
}


