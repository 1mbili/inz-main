provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "existing" {
  name                = "vault0a"
  resource_group_name = "Inzynierka-app"
}

# Create a secret in the existing Azure Key Vault
resource "azurerm_key_vault_secret" "mysql-host" {
  name         = "mysql-host"
  value        = digitalocean_database_cluster.mysqql-example.host
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "mysql-password" {
  name         = "mysql-password"
  value        = digitalocean_database_cluster.mysqql-example.password
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "cloudflare_token" {
  name         = "cloudflaretoken"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "cloudflare_zone_id" {
  name         = "cloudflare-zone-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "digitalocean_token" {
  name         = "digitalocean-token"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "private-ssh-key" {
  name         = "private-vm-key"
  key_vault_id = data.azurerm_key_vault.existing.id
}
