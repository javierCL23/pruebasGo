terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

resource "libvirt_network" "cluster-network" {
  name   = var.vnc_name
  domain = var.domain

  mode      = "nat"
  addresses = [var.vnc_range]
  autostart = true
  dhcp {
    enabled = true
  }
}

