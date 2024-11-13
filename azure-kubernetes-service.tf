# ###################################################
# Create AKS Cluster
# ###################################################

# Create Azure Kubernetes Service Subnets
resource "azurerm_subnet" "aks_subnet" {
  name                        = "${var.env}-${var.appname}-vnet"
  resource_group_name         = var.resource_group_name
  virtual_network_name        = azurerm_virtual_network.virtual_network.name
  address_prefixes            = var.aks_subnet_address_prefixes
}

# Create Azure Kubernetes Service Network Security Group
resource "azurerm_network_security_group" "aks_network_security_group" {
  name                        = "${var.env}-${var.appname}-aks-nsg"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
}

# Create Azure Kubernetes Service Network Security Groups Rules
# Locals Block for Azure Kubernetes Service Security Rules
locals {
  aks_nsg_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }
}
# Azure Kubernetes Service Network Security Groups Inbound Rule
resource "azurerm_network_security_rule" "aks_nsg_rule_inbound" {
  for_each                    = local.aks_nsg_inbound_ports_map
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_network_security_group.name
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# Associate Azure Kubernetes Service Network Security Group and Subnet
resource "azurerm_subnet_network_security_group_association" "aks_nsg_to_subnet_association" {
  depends_on                  = [azurerm_network_security_rule.aks_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                   = azurerm_subnet.aks_subnet.id
  network_security_group_id   = azurerm_network_security_group.aks_network_security_group.id
}

# Create Azure Kubernetes Service Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                        = "${var.env}-${var.appname}-aks"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  dns_prefix                  = "${var.env}-${var.appname}-aks"
  kubernetes_version          = var.aks_kubernetes_version

  service_principal {
    client_id                 = var.aks_service_principal_id
    client_secret             = var.aks_service_principal_secret
  }

  role_based_access_control_enabled = true

  # Add Default Node Pool
  default_node_pool {
    name                      = var.default_pool_name
    vm_size                   = var.default_pool_node_vm_size
    node_count                = var.default_pool_node_count
    orchestrator_version      = var.aks_kubernetes_version
    enable_auto_scaling       = true
    min_count                 = var.default_pool_min_node_count
    max_count                 = var.default_pool_max_node_count
  }
  linux_profile {
    admin_username            = "${var.env}_${var.appname}_administrator"

    ssh_key {
      key_data                = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }

  # Add Network Profile
  network_profile {
    network_plugin            = "kubenet"
    load_balancer_sku         = "standard"
  }

  # Add Application Ingress Gateway Controller
  ingress_application_gateway {
    gateway_name = var.app_gateway_name
    subnet_cidr = var.app_gateway_subnet_cidr
  }

  # Add Network Profile
  depends_on = [
    #azurerm_resource_group.resource_group,
    azurerm_subnet.aks_subnet,
    azurerm_subnet_network_security_group_association.aks_nsg_to_subnet_association
  ]
}

###################################################
# Create AKS Node Pools
###################################################

# Create RTF Node Pool
#resource "azurerm_kubernetes_cluster_node_pool" "aks_apigee_runtime_pool" {
#  kubernetes_cluster_id     = azurerm_kubernetes_cluster.aks.id
#  name                      = var.apigee_runtime_pool_name
#  vm_size                   = var.apigee_runtime_pool_node_vm_size
#  node_count                = var.apigee_runtime_pool_node_count
#  orchestrator_version      = var.aks_kubernetes_version
#  enable_auto_scaling       = true
#  min_count                 = var.apigee_runtime_pool_min_node_count
#  max_count                 = var.apigee_runtime_pool_max_node_count

#   node_labels = {
#    "cloud.google.com/gke-nodepool" = "apigee-runtime"
#  }

#}


resource "azurerm_kubernetes_cluster_node_pool" "aks_apigee_data_pool" {
  kubernetes_cluster_id     = azurerm_kubernetes_cluster.aks.id
  name                      = var.apigee_data_pool_name
  vm_size                   = var.apigee_data_pool_node_vm_size
  node_count                = var.apigee_data_pool_node_count
  orchestrator_version      = var.aks_kubernetes_version
  enable_auto_scaling       = true
  min_count                 = var.apigee_data_pool_min_node_count
  max_count                 = var.apigee_data_pool_max_node_count

   node_labels = {
    "cloud.google.com/gke-nodepool" = "apigee-data"
  }

}

###################################################
# Assign Admin Role to AKS Cluster
###################################################

resource "azurerm_role_assignment" "aks_cluster_admin_assignment1" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  principal_id         = var.dev_ops_group_id
}