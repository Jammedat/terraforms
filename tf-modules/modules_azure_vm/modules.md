# How to use this module to create a resources with virtual machine on azure

## Create a terraform file -> main.tf

Paste the following 
```
provider "azurerm" {
  features {}
  
}
```
Provide the path of modules and the change the names of the fields  
```
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
```
