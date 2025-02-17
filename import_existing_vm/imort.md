# Importing an Existing Azure Resource into Terraform

To import an existing Azure resource (such as a virtual machine) into Terraform, you use the `terraform import` command. This command allows you to bring an existing resource under Terraform management by associating it with a resource definition in your Terraform configuration.

## Steps to Import an Existing Azure Resource

### 1. Define the Resource in Terraform Configuration
Create a Terraform configuration file (e.g., `main.tf`) and define the resource you want to import:

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_virtual_machine" "example" {
  name                = "example-vm"
  location            = "East US"
  resource_group_name = "example-resource-group"
  vm_size             = "Standard_DS1_v2"
  # Add other required configuration here
}
```
Replace the attributes with the actual values for your resource.

### 2. Run `terraform init`
Initialize your Terraform working directory:

```bash
terraform init
```

### 3. Run `terraform import`
Use the `terraform import` command:

```bash
terraform import <resource_type>.<resource_name> <resource_id>
```

For an Azure virtual machine:

```bash
terraform import azurerm_virtual_machine.example /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Compute/virtualMachines/<vm_name>
```

### 4. Verify the Import
```bash
terraform state list
```

### 5. Update the Terraform Configuration
```bash
terraform show
```
Copy relevant attributes and update your `main.tf`.

### 6. Plan and Apply
```bash
terraform plan
terraform apply
```

