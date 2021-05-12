
resource "null_resource" "winrm" {
  provisioner "ansible" {
    plays {
      playbook {
        file_path  = "winrm.yml"
      }
      inventory_file = "inventory.yml"
      verbose        = true
      forks          = 15
      extra_vars = {
        # Hosts
        "service_hosts" = "windows_servers"
        # Ansible
        "ansible_user"                         = "administrator"
        "ansible_password"                     = "0v9ketFl6p4334zzWlY2"
        "ansible_connection"                   = "winrm"
        "ansible_winrm_server_cert_validation" = "ignore"
      }
    }
    ansible_ssh_settings {
      insecure_no_strict_host_key_checking = true
      connect_timeout_seconds              = 120
      connection_attempts                  = 3
    }
  }
  connection {
    type        = "ssh"
    user        = "root"
    host        = "0.0.0.0"
    private_key = var.ssh_private_key
  }
}

variable "ssh_private_key" {
  description = "ssh private key"
}
