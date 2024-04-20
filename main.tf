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
  disable_password_authentication = false
  admin_ssh_key {
    username   = "TerraformMachine"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoc6GnTCmyRe41OlXq4FYQABqnEa7U7K6nzPytadgQObo708kvaW9IbnhOoDIacPcDo+Kj/DmKwl59+pjptKbo38bKP7A/e9VTcfIlJQDGgKpXp41Z2riaUrIEjPwgLdM6CnWObWlqPTtMduxSkrTel1lqrG35n60YgeNEiIjJNUBdtR2rbTsMGkNGlgozIQj7zPQqs/5SA9gT6/ElV2F7DEtyEpWwQb4G5ZgftwwT7WtuUAkX6L9EmyWg3Q1vt9JjhMmduBY6FgvQOc8ItZjgUsF3iM5vwlmdIWrEf6Bg126j8XYu75Nf8nSR4Et8vWdxi9hMMFYuC9TI7B3ixsEA7QWKn2GayVqO6yI6msyWmCPpkISbdXs808HS/ts5FoyJrDApcXfh1mYeWtTO2YkivWPxo625bsS/pxeJDqF67PHuOl8ruYvPz/rdxaeUk7mJZPcmN/bxVAWmlC8xrlXwuknpKWYahMHgmE4liLp2WIyI3xudb0tG5W7t9oqpk3E= generated-by-azure"  
  }

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

