terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "test_file" {
  filename = var.path_file
  content  = <<EOT
¡Hola! 👋
Este archivo fue generado con Terraform.
Ruta del módulo: ${path.module}
EOT
}
