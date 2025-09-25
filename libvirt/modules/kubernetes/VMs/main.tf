terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}


data "template_file" "cloudinit_config" {
  template = file("${path.module}/cloudinit.cfg")
  vars = {
    user_name = var.user_name
    ssh_users = join(",", var.github_users)
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}


resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.cloudinit_config.rendered
  network_config = data.template_file.network_config.rendered
  pool           = var.pool_name
}


resource "libvirt_domain" "VMs" {
  for_each = var.machine_specs

  depends_on = [
    libvirt_cloudinit_disk.commoninit
  ]

  name   = each.key
  memory = each.value.memory
  vcpu   = each.value.cpu

  disk {
    volume_id = var.volume_ids[each.key] # tu disco principal
  }

  network_interface {
    network_id = var.vnc_id
    wait_for_lease = true
  }
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id
}
