# resource "azurerm_mysql_server" "mysql-server" {
#   name                = data.azurerm_key_vault_secret.mysql-host.value
#   location            = azurerm_resource_group.inzunierkapw.location
#   resource_group_name = azurerm_resource_group.inzunierkapw.name

#   administrator_login          = data.azurerm_key_vault_secret.mysql-user.value
#   administrator_login_password = data.azurerm_key_vault_secret.mysql-password.value

#   sku_name   = "B_Gen5_1"
#   storage_mb = 5120
#   version    = "8.0"

#   auto_grow_enabled                 = true
#   backup_retention_days             = 7
#   geo_redundant_backup_enabled      = false
#   infrastructure_encryption_enabled = false
#   public_network_access_enabled     = true
#   ssl_enforcement_enabled           = true
#   ssl_minimal_tls_version_enforced  = "TLS1_2"
# }
