#Config CP
resource "null_resource" "configure_CP" {
  connection {
    type        = "ssh"
    host        = var.cp_ip
    user        = var.cp_user
    private_key = file(var.private_key)
  }

  #Copiar todos los scripts que tienen que ejecutar el CP
  provisioner "file" {
    source      = "${path.root}/libvirt_scripts"
    destination = "/tmp/scripts"
  }
  
  #Ejecutar los scripts copiados
  provisioner "remote-exec" {
    inline = [
      for s in var.cp_scripts : "bash /tmp/scripts/${basename(s)}"
    ]
  }
}

#Obtener join command del CP y guardar en local para workers
resource "null_resource" "get_join_command" {
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no ${var.cp_user}@${var.cp_ip}:/tmp/scripts/join_command.sh /tmp/join_command.sh"
  }
  depends_on = [null_resource.configure_CP]
}


#Config Workers
resource "null_resource" "configure_workers" {
  #Ejecutar en todas las máquinas no CP
  for_each = { for name, vm in var.machines : name => vm if name != "CP" }
  
  connection {
    type        = "ssh"
    host        = each.value.ip
    user        = each.value.user
    private_key = file(var.private_key)
  }

  #Copiar todos los scripts que tienen que ejecutar los workers
  provisioner "file" {
    source      = "${path.root}/libvirt_scripts"
    destination = "/tmp/scripts"
  }

  provisioner "file" {
    source     = "/tmp/join_command.sh"
    destination = "/tmp/scripts/join_command.sh"
  }
  #Ejecutar los scripts copiados
  provisioner "remote-exec" {
    inline = concat(
      ["chmod +x /tmp/scripts/*"],
      [for s in var.worker_scripts : "sudo bash /tmp/scripts/${basename(s)}"],
      ["sudo hostnamectl set-hostname ${each.key}"],
      ["sudo bash /tmp/scripts/join_command.sh"]
    )
  }
  depends_on = [null_resource.get_join_command]
}
