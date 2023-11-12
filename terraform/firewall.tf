provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_token.value
}

resource "cloudflare_record" "lb" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "notatnik"
  value   = digitalocean_droplet.load_balancer[0].ipv4_address
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "cdn" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "cdn"
  value   = digitalocean_droplet.content_delivery_network[0].ipv4_address
  type    = "A"
  proxied = true
}
