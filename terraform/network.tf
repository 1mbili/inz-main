resource "digitalocean_vpc" "siec_aplikacji" {
  name     = "example-project-network"
  region   = "nyc3"
  ip_range = "10.10.10.0/24"
}