###################################################
# Create Azure Container Registry
###################################################

# Create Azure Container Registry subnet
#resource "azurerm_subnet" "acr_subnet" {
#  name                 = "${var.env}-${var.appname}-sub-acr0"
#  resource_group_name  = azurerm_resource_group.resource_group.name
#  virtual_network_name = azurerm_virtual_network.virtual_network.name
#  address_prefixes     = var.acr_subnet_address_prefixes
#}

# Create Azure Container Registry Security Group
/* resource "azurerm_network_security_group" "acr_network_security_group" {
  name                          = "${var.env}-${var.appname}-acr-nsg"
  location                      = azurerm_resource_group.resource_group.location
  resource_group_name           = azurerm_resource_group.resource_group.name
} */

# Create Azure Container Service Network Security Groups Rules
# Locals Block for Security Rules
/* locals {
    acr_nsg_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  } 
} */
# Azure Container Service Network Security Groups Inbound Rule
/* resource "azurerm_network_security_rule" "acr_nsg_rule_inbound" {
  for_each = local.acr_nsg_inbound_ports_map
    resource_group_name         = azurerm_resource_group.resource_group.name
    network_security_group_name = azurerm_network_security_group.acr_network_security_group.name
    name                        = "Rule-Port-${each.value}"
    priority                    = each.key
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = each.value 
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
} */

# Associate Azure Kubernetes Service Network Security Group and Subnet
/* resource "azurerm_subnet_network_security_group_association" "acr_nsg_to_subnet_association" {
  depends_on                    = [ azurerm_network_security_rule.acr_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                     = azurerm_subnet.acr_subnet.id
  network_security_group_id     = azurerm_network_security_group.acr_network_security_group.id
} */

# Create Azure Container Registry
/* resource "azurerm_container_registry" "acr" {  
  name                          = "${var.env}apigeeacr"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  sku                           = var.acr_sku
  admin_enabled                 = var.acr_admin_enabled
#   data_endpoint_enabled         = var.acr_admin_enabled

#   georeplications {
#     location = vars.acr_geo_replication_locations
#   }
  
#   zone_redundancy_enabled     = true
  
#   identity {
#     type = "UserAssigned"
#     identity_ids = [
#       azurerm_user_assigned_identity.acr_identity.id
#     ]
#   }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [ 
    azurerm_resource_group.resource_group,
    azurerm_subnet.acr_subnet,
    azurerm_subnet_network_security_group_association.acr_nsg_to_subnet_association
   ]
} */