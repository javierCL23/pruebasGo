#========================
# Networking variables
#========================

vnc_name  = "k8s-vnc"
domain    = "cluster.local"
vnc_range = "10.21.0.0/16"

#========================
# Cluster variables
#========================

cluster_name = "Cluster_Test"
volumes_path = "/home/jcarreno/K8s_Volumes"
iso_path     = "/var/lib/libvirt/images/isos/ubuntu-24.04-minimal-cloudimg-amd64.img"
github_users = ["jcarreno2312"]
user_name    = "k8sUser"
#========================
# Node specifications
#========================

machine_specs = {
  CP = {
    cpu    = 2
    memory = 4096
    disk   = 10 * 1024 * 1024 * 1024
    ip     = "10.21.1.1"
  },
  Worker1 = {
    cpu    = 2
    memory = 2048
    disk   = 10 * 1024 * 1024 * 1024
    ip     = "10.21.1.2"
  },
  #  Worker2 = {
  #    cpu    = 2
  #    memory = 2048
  #    disk   = 10 * 1024 * 1024 * 1024
  #  }
}


#=======================
#   Kubernetes Config  
#=======================
worker_scripts = ["./libvirt_scripts/commandsVM.sh","./libvirt_scripts/worker_VM.sh"]
cp_scripts = ["./libvirt_scripts/commandsVM.sh","./libvirt_scripts/CP_VM.sh"]
private_key = "~/.ssh/id_ed25519_github"
