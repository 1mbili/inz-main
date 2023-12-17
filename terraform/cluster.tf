resource "digitalocean_kubernetes_cluster" "inz-kubernetes" {
  name   = "inz-kubernetes"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.28.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    node_count = 2

  }
}

resource "local_file" "kube_config" {
  content  = digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].raw_config
  filename = pathexpand("~/.kube/config")
}
