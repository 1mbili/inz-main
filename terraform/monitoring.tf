# Create public IPs

resource "azurerm_public_ip" "monitoring_public_ip" {
  name                = "monitoring-0-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "monitoring_nic" {
  name                = "monitoring-0-NIC"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.monitoring_public_ip.id
  }
}


# Create virtual machine
resource "azurerm_linux_virtual_machine" "monitoring" {
  name                  = "monitoring-0"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.monitoring_nic.id]
  size                  = "Standard_B1s"

  os_disk {
    name                 = "myOsDiskmonitoring"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = "szef"
  admin_ssh_key {
    username   = "szef"
    public_key = data.azurerm_key_vault_secret.public-ssh-key.value
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.example.primary_blob_endpoint
  }
}