resource "digitalocean_kubernetes_cluster" "inz-kubernetes" {
  name   = "inz-kubernetes"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.28.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-1gb"
    node_count = 2

  }
}