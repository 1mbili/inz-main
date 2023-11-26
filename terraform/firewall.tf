provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_token.value
}

resource "cloudflare_record" "lb" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "notatnik"
  value   = azurerm_linux_virtual_machine.cdn.public_ip_address
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "cdn" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "cdn"
  value   = azurerm_linux_virtual_machine.cdn.public_ip_address
  type    = "A"
  proxied = true
}
