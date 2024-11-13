# ###################################################
# # Create Azure Key Vault 
# ###################################################

# # Create Azure Key Vault subnet
# resource "azurerm_subnet" "akv_subnet" {
#   name                 = "${var.env}-${var.appname}-sub-kv0"
#   resource_group_name  = azurerm_resource_group.resource_group.name
#   virtual_network_name = azurerm_virtual_network.virtual_network.name
#   address_prefixes     = var.akv_subnet_address_prefixes
# }

# # Create Azure Key Vault Security Group
# resource "azurerm_network_security_group" "akv_network_security_group" {
#   name                = "${var.env}-${var.appname}-kv-nsg"
#   location            = azurerm_resource_group.resource_group.location
#   resource_group_name = azurerm_resource_group.resource_group.name
# }

# # Create Azure Kubernetes Service Network Security Groups Rules
# # Locals Block for Azure Key Vault Security Rules
# locals {
#     akv_nsg_inbound_ports_map = {
#     "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
#     "110" : "443",
#     "120" : "22"
#   } 
# }

# # Azure Key Vault Network Security Groups Inbound Rule
# resource "azurerm_network_security_rule" "akv_nsg_rule_inbound" {
#   for_each = local.akv_nsg_inbound_ports_map
#     resource_group_name         = azurerm_resource_group.resource_group.name
#     network_security_group_name = azurerm_network_security_group.akv_network_security_group.name
#     name                        = "Rule-Port-${each.value}"
#     priority                    = each.key
#     direction                   = "Inbound"
#     access                      = "Allow"
#     protocol                    = "Tcp"
#     source_port_range           = "*"
#     destination_port_range      = each.value 
#     source_address_prefix       = "*"
#     destination_address_prefix  = "*"
# }

# # Associate Azure Key Vault Network Security Group and Subnet
# resource "azurerm_subnet_network_security_group_association" "akv_nsg_to_subnet_association" {
#   depends_on                = [ azurerm_network_security_rule.akv_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
#   subnet_id                 = azurerm_subnet.akv_subnet.id
#   network_security_group_id = azurerm_network_security_group.akv_network_security_group.id
# }

# # Create Azure Key Vault
# resource "azurerm_key_vault" "key_vault" {
#   name                            = "${var.env}-${var.appname}-kv"
#   location                        = azurerm_resource_group.resource_group.location
#   resource_group_name             = azurerm_resource_group.resource_group.name
#   sku_name                        = var.akv_sku
#   tenant_id                       = var.tenant_id
#   enabled_for_disk_encryption     = var.akv_for_disk_encryption_enabled
#   enabled_for_deployment          = var.akv_for_deployment_enabled
#   enabled_for_template_deployment = var.akv_template_deployment_enabled
#   purge_protection_enabled        = var.akv_purge_protection_enabled
# }


# # Grant permissions to the Service Principal
# resource "azurerm_key_vault_access_policy" "sp_access_policy" {
#   key_vault_id = azurerm_key_vault.key_vault.id

#   tenant_id = var.tenant_id
#   object_id = "46b4ef77-0733-4afb-a60c-56c30d290a4f"

#   secret_permissions = [
#     "Get",
#     "List",
#     "Set",
#     "Delete",
#     "Recover",
#     "Backup",
#     "Restore",
#     "Purge",
#   ]

#   key_permissions = [
#     "Get",
#     "List",
#     "Update",
#     "Create",
#     "Import",
#     "Delete",
#     "Recover",
#     "Backup",
#     "Restore",
#     "Decrypt",
#     "Encrypt",
#     "UnwrapKey",
#     "WrapKey",
#     "Verify",
#     "Sign",
#     "Purge",
#     "Release",
#     "Rotate",
#     "GetRotationPolicy",
#     "SetRotationPolicy"
#   ]

#   certificate_permissions = [
#     "Get",
#     "List",
#     "Update",
#     "Create",
#     "Import",
#     "Delete",
#     "Recover",
#     "Backup",
#     "Restore",
#     "ManageContacts",
#     "ManageIssuers",
#     "GetIssuers",
#     "ListIssuers",
#     "SetIssuers",
#     "DeleteIssuers",
#     "Purge"
#   ]
# }