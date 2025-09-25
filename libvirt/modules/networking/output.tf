output "all_outputs" {
  value = {
    network = {
      name      = libvirt_network.cluster-network.name
      domain    = libvirt_network.cluster-network.domain
      mode      = libvirt_network.cluster-network.mode
      address = libvirt_network.cluster-network.addresses[0]
    }
  }
}

output "net_id" {
  value = libvirt_network.cluster-network.id
}
