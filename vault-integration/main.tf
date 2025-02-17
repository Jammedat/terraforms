terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.41.0"
    }
  }

  required_version = ">= 1.2.0"
}


provider "azurerm" {
  features {}
  
}

provider "vault" {
  address = "http://20.84.40.169:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "14010e3d-249f-26da-cd8a-54476e747085"
      secret_id = "b99f984a-f15c-954c-b58f-212bbce7ffd6"

    }
  }
}

#to read you use data & to write you use resource
data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type = string
  default = "new-resources"
  
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "West US 2"
  tags = {
    secret = data.vault_kv_secret_v2.example.data["user"]
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create a subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a network interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B1s"  # Equivalent to AWS t2.micro
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")  # Path to your public SSH key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
