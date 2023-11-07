provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_token.value
}

resource "cloudflare_record" "www" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "cdupsko"
  value   = digitalocean_droplet.load_balancer[0].ipv4_address
  type    = "A"
  proxied = true
}
