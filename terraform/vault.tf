data "azurerm_key_vault" "existing" {
  name                = "vault0a"
  resource_group_name = "Inzynierka-app"
}

data "azurerm_key_vault_secret" "azure-db-host" {
  name         = "azure-db-host"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "mysql-password" {
  name         = "mysql-password"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "azure-mysql-user" {
  name         = "azure-mysql-user"
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

data "azurerm_key_vault_secret" "public-ssh-key" {
  name         = "public-vm-key"
  key_vault_id = data.azurerm_key_vault.existing.id
}