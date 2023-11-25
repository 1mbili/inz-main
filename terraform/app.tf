resource "digitalocean_droplet" "web" {
  count  = 2
  image  = "ubuntu-22-04-x64"
  name   = "www-${count.index}"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.siec_aplikacji.id
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = data.azurerm_key_vault_secret.private-ssh-key.value
    timeout     = "2m"
  }

}

resource "digitalocean_droplet" "load_balancer" {
  count  = 1
  image  = "ubuntu-22-04-x64"
  name   = "load-balancer-${count.index}"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.siec_aplikacji.id
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = data.azurerm_key_vault_secret.private-ssh-key.value
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install python3 -y"
    ]
  }
}

resource "digitalocean_droplet" "monitoring" {
  count  = 1
  image  = "ubuntu-22-04-x64"
  name   = "monitoring-${count.index}"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.siec_aplikacji.id
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = data.azurerm_key_vault_secret.private-ssh-key.value
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install python3 -y"
    ]
  }
}

resource "digitalocean_droplet" "content_delivery_network" {
  count  = 1
  image  = "ubuntu-22-04-x64"
  name   = "cdn-${count.index}"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.siec_aplikacji.id
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = data.azurerm_key_vault_secret.private-ssh-key.value
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install python3 -y"
    ]
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("templates/anisble_inventory.tpl",
    {
      monitoring-vms = digitalocean_droplet.monitoring
      web-vms        = digitalocean_droplet.web
      lb-vms         = digitalocean_droplet.load_balancer
      cdn-vms        = digitalocean_droplet.content_delivery_network
    }
  )
  filename = "../ansible/inventory.ini"
}

resource "local_file" "ansible_main" {
  content = templatefile("templates/main.yml.tpl",
    {
      monitoring-vms = digitalocean_droplet.monitoring
      web-vms        = digitalocean_droplet.web
      lb-vms         = digitalocean_droplet.load_balancer
      cdn-vms        = digitalocean_droplet.content_delivery_network
    }
  )
  filename = "../ansible/main.yml"
}
