output "all_outputs" {
  value = {
    VMs   = module.VMs.all_outputs
    VMs_Pool = module.VMs_Pool.all_outputs
  }
}
