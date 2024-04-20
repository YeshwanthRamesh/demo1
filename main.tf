resource "azurerm_resource_group" "EastUSAYeshwanth" {
  name     = "EastUSAYeshwanth"
  location = "East US"
}

resource "azurerm_virtual_network" "YeshwanthVirtualNetwork" {
  name                = "YeshwanthVirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.EastUSAYeshwanth.location
  resource_group_name = azurerm_resource_group.EastUSAYeshwanth.name
}

resource "azurerm_subnet" "YeshwanthSubNet" {
  name                 = "YeshwanthSubNet"
  resource_group_name  = azurerm_resource_group.EastUSAYeshwanth.name
  virtual_network_name = azurerm_virtual_network.YeshwanthVirtualNetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_network_interface" "YeshwanthNetworkInterface" {
  name                = "YeshwanthNetworkInterface"
  location            = azurerm_resource_group.EastUSAYeshwanth.location
  resource_group_name = azurerm_resource_group.EastUSAYeshwanth.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.YeshwanthSubNet.id
    private_ip_address_allocation = "Dynamic"
  }


}

resource "azurerm_linux_virtual_machine" "TerraformMachine" {
  name                = "TerraformMachine"
  resource_group_name = azurerm_resource_group.EastUSAYeshwanth.name
  location            = azurerm_resource_group.EastUSAYeshwanth.location
  size                = "Standard_DS1_v2"

  admin_username = "TerraformMachine"
  admin_password = "Abbuyesh1"

  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.YeshwanthNetworkInterface.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
output publicIP {
			value = azurerm_virtual_network.YeshwanthVirtualNetwork.public_ip_address
		}

