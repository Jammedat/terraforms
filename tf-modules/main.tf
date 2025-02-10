provider "azurerm" {
  features {}
  
}

module "azure_vm" {
  source = "./modules_azure_vm"
  
    resource_group_name = "resource1"
    location = "West US 2"
    virtual_network_name = "example-vnet"
    subnet_name = "example-subnet"
    network_interface_name = "example-nic"
    vm_name = "example-vm"
    public_ip_name = "example-pip"


}
