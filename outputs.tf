###################################################
# Shared resources outputs
###################################################
# Resource Group Name
#output "resource_group_name" {
#  value = azurerm_resource_group.resource_group.name
#}

# Resource Group Location
/* output "resource_group_location" {
  value = azurerm_resource_group.resource_group.location
  
} */

# Virtual Network Name
output "virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.virtual_network.name
}

# Virtual Network ID
output "virtual_network_id" {
  description = "Virtual Network ID"
  value = azurerm_virtual_network.virtual_network.id
}

# ###################################################
# # Azure Kubernetes Service Outputs
# ###################################################
# # Azure Kubernetes Service subnet name 
# output "aks_subnet_name" {
#   description = "Azure Kubernetes Service subnet name"
#   value = azurerm_subnet.aks_subnet.name
# }

# # Azure Kubernetes Service Subnet ID
# output "aks_subnet_id" {
#   description = "AKS subnet ID"
#   value = azurerm_subnet.aks_subnet.id
# }

# # Azure Kubernetes Service Network Security Group name 
# output "aks_nsg_name" {
#   description = "Azure Kubernetes Service Subnet Service Network Security Group name"
#   value = azurerm_network_security_group.aks_network_security_group.name
# }

# # Azure Kubernetes Service  Subnet NSG ID 
# output "aks_subnet_nsg_id" {
#   description = "Azure Kubernetes Service Network Securit Group ID"
#   value = azurerm_network_security_group.aks_network_security_group.id
# }

# # Azure Kubernetes Service cluster name
# output "kubernetes_cluster_name" {
#   value = azurerm_kubernetes_cluster.aks.name
# }

# # Azure Kubernetes Service cluster ID 
# output "kubernetes_cluster_id" {
#   value = azurerm_kubernetes_cluster.aks.id
# }

# # Azure Kubernetes Service kubeconfig
# output "kube_config" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive = true
# }

# --------------------------------------------------------------------------------

# # Azure Kubernetes Service  client certificate
# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
#   sensitive = true
# }

# # Azure Kubernetes Service  cluster client key
# output "client_key" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
#   sensitive = true
# }

# # Azure Kubernetes Service  cluster CA certificate
# output "cluster_ca_certificate" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
#   sensitive = true
# }

# # Azure Kubernetes Service  cluster password
# output "cluster_password" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].password
#   sensitive = true
# }

# # # Azure Kubernetes Service  cluster username
# output "cluster_username" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].username
#   sensitive = true
# }

# # Azure Kubernetes Service  cluster host
# output "host" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config[0].host
#   sensitive = true
# }

# ###################################################
# Azure Container Registry outputs
# ###################################################
# # Azure Container Registry subnet name 
# output "acr_subnet_name" {
#   description = "Azure Kubernetes Service subnet name"
#   value = azurerm_subnet.acr_subnet.name
# }

# # Azure Container Registry subnet ID
# output "acr_subnet_id" {
#   description = "Azure Container Registry subnet ID"
#   value = azurerm_subnet.acr_subnet.id
# }

# # Azure Container Registry Name
# output "acr_name" {
#   value = azurerm_container_registry.acr.name
# }

# # Azure Container Registry ID
# output "acr_id" {
#   value = azurerm_container_registry.acr.id
# }

# # Azure Container Registry resource group name
# output "acr_resource_group_name" {
#   value = azurerm_container_registry.acr.resource_group_name
# }

# # Azure Container Registry login server
# output "acr_login_server" {
#   value = azurerm_container_registry.acr.login_server
# }

# # Azure Container Registry login server URL 
# output "acr_login_server_url" {
#   value = azurerm_container_registry.acr.login_server_url
# }

# # Azure Container Registry admin username
# output "acr_admin_username" {
#   value = azurerm_container_registry.acr.admin_username
# }

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].username
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}