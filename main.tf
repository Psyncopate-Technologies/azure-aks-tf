##########################################################################
# Create resource Group and Subnet
##########################################################################

# Create resource group 
/* resource "azurerm_resource_group" "resource_group" {
  name     = "${var.env}-${var.appname}-rg"
  location = var.region
  tags     = local.common_tags
} */

resource "azurerm_role_assignment" "contributor_assignment" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/psy-flink-poc"
  role_definition_name = "Contributor"
  principal_id         = var.dev_ops_group_id  # Replace with the User's Azure AD Object ID

  #depends_on           = [azurerm_resource_group.resource_group]
}

# Create virtual private network (VNet)
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.env}-${var.appname}-vnet"
  #resource_group_name = azurerm_resource_group.resource_group.name
  resource_group_name = var.resource_group_name
  #location            = azurerm_resource_group.resource_group.location
  location            = var.resource_group_location 
  address_space       = var.virtual_network_address_spaces
}

