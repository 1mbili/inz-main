resource "local_file" "ansible_inventory" {
  content = templatefile("templates/anisble_inventory.tpl",
    {
      monitoring-vms = [azurerm_linux_virtual_machine.monitoring]
      web-vms        = [azurerm_linux_virtual_machine.web-0, azurerm_linux_virtual_machine.web-1]
      lb-vms         = [azurerm_linux_virtual_machine.lb]
      cdn-vms        = [azurerm_linux_virtual_machine.cdn]
    }
  )
  filename = "../ansible/inventory.ini"
}

resource "local_file" "ansible_main" {
  content = templatefile("templates/main.yml.tpl",
    {
      monitoring-vms = [azurerm_linux_virtual_machine.monitoring]
      web-vms        = [azurerm_linux_virtual_machine.web-0, azurerm_linux_virtual_machine.web-1]
      lb-vms         = [azurerm_linux_virtual_machine.lb]
      cdn-vms        = [azurerm_linux_virtual_machine.cdn]
    }
  )
  filename = "../ansible/main.yml"
}