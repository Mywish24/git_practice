resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnetCIDR
  dns_servers         = var.dns_servers

  
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "vmss" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.webCIDR
}

resource "azurerm_virtual_machine_scale_set" "main" {
  name                = "${var.prefix}-vmss"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  upgrade_policy_mode = "Automatic"

  sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity = 2
  }

  os_profile {
    computer_name_prefix = "${var.prefix}-os"
    admin_username       = var.username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys  {
    key_data   = file("C:/Users/Kavali Divya/.ssh/id_rsa.pub")
    path       = "/home/Azuser/.ssh/authorized_keys"  
    }
  }

  network_profile {
    name    = "${var.prefix}-Np"
    primary = true

    ip_configuration {
      name      = "${var.prefix}-IpConfig"
      primary   = true
      subnet_id = azurerm_subnet.vmss.id
    }
  }

  storage_profile_os_disk {
    name           = "${var.prefix}-disk"
    caching        = "ReadWrite"
    create_option  = "FromImage"
    vhd_containers = ["${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.container.name}"]
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
