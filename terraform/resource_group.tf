resource "azurerm_resource_group" "example" {
  name     = "inzynierka-resources3"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "inzynierkastorages3"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}