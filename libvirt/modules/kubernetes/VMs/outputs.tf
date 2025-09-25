output "all_outputs" {
  description = "Información de todas las VMs creadas"
  value = {
    for name, vm in libvirt_domain.VMs : name => {
      name   = vm.name
      memory = vm.memory
      vcpu   = vm.vcpu
      ip     = try(vm.network_interface[0].addresses[0],null)
      user   = var.user_name
      gh_users = join(",", var.github_users)
    }
  }
}

output "machines"{
  value = {
    for name, vm in libvirt_domain.VMs : name => {
      id     = vm.id
      name   = vm.name
      memory = vm.memory
      vcpu   = vm.vcpu
      ip     = try(vm.network_interface[0].addresses[0],null)
      user   = var.user_name
      gh_users = join(",", var.github_users)
    }
  }
}
