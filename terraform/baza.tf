resource "azurerm_mysql_server" "mysql-server" {
  name                = data.azurerm_key_vault_secret.azure-db-host.value
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  administrator_login          = data.azurerm_key_vault_secret.azure-mysql-user.value
  administrator_login_password = data.azurerm_key_vault_secret.mysql-password.value

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "8.0"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.mysql-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}