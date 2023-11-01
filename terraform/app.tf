resource "digitalocean_droplet" "web" {
  count = 1
  image = "ubuntu-22-04-x64"
  name = "www-${count.index}"
  region = "nyc3"
  size = "s-2vcpu-2gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]


connection {
  host = self.ipv4_address
  user = "root"
  type = "ssh"
  private_key = file(var.pvt_key)
  timeout = "2m"
}
  
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install python3 -y"
    ]
  }
}


resource "digitalocean_droplet" "load_balancer" {
  count = 1
  image = "ubuntu-22-04-x64"
  name = "load-balancer-${count.index}"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

connection {
  host = self.ipv4_address
  user = "root"
  type = "ssh"
  private_key = file(var.pvt_key)
  timeout = "2m"
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
  count = 1
  image = "ubuntu-22-04-x64"
  name = "monitoring-${count.index}"
  region = "nyc3"
  size = "s-2vcpu-2gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]


connection {
  host = self.ipv4_address
  user = "root"
  type = "ssh"
  private_key = file(var.pvt_key)
  timeout = "2m"
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
  content = templatefile("anisble_inventory.tpl",
    {
     monitoring-vms = digitalocean_droplet.monitoring
     web-vms = digitalocean_droplet.web
     lb-vms = digitalocean_droplet.load_balancer
    }
  )
  filename = "../ansible/inventory.ini"
}

resource "local_file" "ansible_main" {
  content = templatefile("main.yml.tpl",
    {
     monitoring-vms = digitalocean_droplet.monitoring
     web-vms = digitalocean_droplet.web
     lb-vms = digitalocean_droplet.load_balancer
    }
  )
  filename = "../ansible/main.yml"
}