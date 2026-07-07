### Multi-Environment Workspaces

To deploy across **dev**, **test**, and **prod** without duplicating your codebase, use `terraform.workspace`. Every resource name must be dynamic to prevent "Resource Already Exists" collision errors. 


```
locals {
  env = terraform.workspace

  # Distinct IP networks prevent overlapping block issues
  vnet_cidr = {
    dev  = ["10.1.0.0/16"]
    test = ["10.2.0.0/16"]
    prod = ["10.3.0.0/16"]
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.env}-demo-group" # Resolves to "dev-demo-group", etc.
  location = "koreacentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.env}-demo-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = lookup(local.vnet_cidr, local.env, ["10.0.0.0/16"])
}
```


***

### Module Communication (Outputs & Inputs)

Modules operate like isolated black boxes. To share data between a network module and a root VM module, you must **Output** the values from the child module and capture them in the root configuration. 

In `modules/network/outputs.tf`:



```
output "nic_id" {
  value = azurerm_network_interface.nic.id
}
```



In Root `main.tf`:



```
module "network" {
  source = "./modules/network"
  # ... inputs ...
}

resource "azurerm_linux_virtual_machine" "vm" {
  # Read the value exported by the network module
  network_interface_ids = [module.network.nic_id]
  # ... rest of configuration ...
}
```



***

### Advanced Control: Loops, Firewalls, & Lifecycles

Loops: `count` vs `for_each`

* **`count` (Index-based):** Tracks resources by numbers (`[0], [1]`). Dropping a resource in the middle forces a cascade shift, causing unintended destructions. 
* **`for_each` (Key-based):** Tracks resources by explicit names (`["web"], ["api"]`). Deleting a single key removes only that item, keeping the rest of your production intact. 

Dynamic Blocks (NSG Optimization)

Instead of copy-pasting hundreds of lines of `security_rule {}` configurations for the security team, iterate over a single map structure: 



```
dynamic "security_rule" {
  for_each = local.security_rules
  content {
    name                   = "allow-${security_rule.key}"
    priority               = security_rule.value.priority
    destination_port_range = security_rule.value.port
    # ... standard baselines ...
  }
}
```



The `lifecycle` Rule

Adding `ignore_changes` stops tracking an attribute **completely** after its initial deployment. It skips updates whether they originate from portal updates *or* modifications within your local `main.tf` code. 



```
lifecycle {
  ignore_changes = [tags] # Completely stops tracking tag comparisons
}
```



***

### Safe Code Refactoring (Avoiding Accidental Destroys)

If you move a resource block into a module or rename it in your files, [Terraform](https://developer.hashicorp.com/terraform) maps it to a new address and defaults to a dangerous **Destroy & Create** pattern. 

Prevent data loss natively using a `moved` block directly in your codebase: 



```
moved {
  from = azurerm_linux_virtual_machine.vm
  to   = module.compute.azurerm_linux_virtual_machine.main
}
```
