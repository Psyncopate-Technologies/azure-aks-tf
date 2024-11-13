# Description: This file contains all the variables used in the terraform manifests.
variable "tenant_id" {
  type          = string
  description   = "The Azure tenant ID."
  
}

# Azure Subscription ID
variable "subscription_id" {
  type          = string
  description   = "The Azure subscription ID."  
}

# Azure Region
variable "region" {
  type          = string
  description   = "The Azure region in which to create the Resource Group."
}
# Azure environment
variable "env" {
  type          = string
  description   = "The Azure environment in which to create the Resource."
}

# Application name
variable "appname" {
  type          = string
  description   = "The Azure application name to which the resource belong."
}

# Azure location
variable "loc" {
  type          = string
  description   = "The Azure location in which to create the Resource."
}

# Application owner name
variable "owner" {
  type          = string
  description   = "The Azure owner of the Resource."
}

# Psncopate Infra DevOps group ID
variable "dev_ops_group_id" {
  type          = string
  description   = "The Azure DevOps group ID."
}

# Azure Kubernetes Service subnet address space
variable "virtual_network_address_spaces" {
  type          = list(string)
  description   = "The list of IP address spaces for subnets in the virtual network."
}

# Azure Kubernetes Service subnet address space
variable "aks_subnet_address_prefixes" {
  type          = list(string)
  description   = "AKS subnet address space."
}

# Azure Kubernetes Service Kubernetes Version
variable "aks_kubernetes_version" {
  type          = string
  description   = "The version of Kubernetes to use for the managed cluster."
}

# Azure Kubernetes Service Service Principal ID
variable "aks_service_principal_id" {
  type          = string
  description   = "The ID of the Service Principal used to access the Kubernetes cluster."
  
}

# Azure Kubernetes Service Service Principal Secret
variable "aks_service_principal_secret" {
  type          = string
  description   = "The secret of the Service Principal used to access the Kubernetes cluster." 
}

# DEFAULT NODE POOL CONFIGURATION
# default node pool name
variable "default_pool_name" {
  type          = string
  description   = "The name of the RTF Node Pool."
}

# default node pool count
variable "default_pool_node_count" {
  type          = number
  description   = "The initial number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
}

# default nodes vm size
variable "default_pool_node_vm_size" {
  type          = string
  description   = "The size of the Virtual Machine."
}

# default nodes disk size
variable "default_pool_node_os_disk_size_gb" {
  type          = number
  description   = "The Disk Size in GB to be used for every Virtual Machine in this Node Pool. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that size of Virtual Machine."
}

# default nodes min count
variable "default_pool_min_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

# default nodes max count
variable "default_pool_max_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

# RTF POOL CONFIGURATION
# rtf node pool name
variable "rtf_pool_name" {
  type    = string
  description = "The name of the RTF Node Pool."
}

# data node pool count
variable "rtf_pool_node_count" {
  type    = number
  description = "The initial number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
}

# data nodes vm size
variable "rtf_pool_node_vm_size" {
  type    = string
  description = "The size of the Virtual Machine."
}

# data nodes disk size
variable "rtf_pool_node_os_disk_size_gb" {
  type    = number
  description = "The Disk Size in GB to be used for every Virtual Machine in this Node Pool. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that size of Virtual Machine."
}

# data nodes min count
variable "rtf_pool_min_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

# data nodes max count
variable "rtf_pool_max_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}


# APIGEE RUNTIME POOL CONFIGURATION
# Apigee runtime node pool name
variable "apigee_runtime_pool_name" {
  type    = string
  description = "The name of the RTF Node Pool."
}

# data node pool count
variable "apigee_runtime_pool_node_count" {
  type    = number
  description = "The initial number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
}

# data nodes vm size
variable "apigee_runtime_pool_node_vm_size" {
  type    = string
  description = "The size of the Virtual Machine."
}

# data nodes disk size
variable "apigee_runtime_pool_node_os_disk_size_gb" {
  type    = number
  description = "The Disk Size in GB to be used for every Virtual Machine in this Node Pool. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that size of Virtual Machine."
}

# data nodes min count
variable "apigee_runtime_pool_min_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

# data nodes max count
variable "apigee_runtime_pool_max_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}


# APIGEE DATA POOL CONFIGURATION
# Apigee data node pool name
variable "apigee_data_pool_name" {
  type    = string
  description = "The name of the RTF Node Pool."
}

# data node pool count
variable "apigee_data_pool_node_count" {
  type    = number
  description = "The initial number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
}

# data nodes vm size
variable "apigee_data_pool_node_vm_size" {
  type    = string
  description = "The size of the Virtual Machine."
}

# data nodes disk size
variable "apigee_data_pool_node_os_disk_size_gb" {
  type    = number
  description = "The Disk Size in GB to be used for every Virtual Machine in this Node Pool. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that size of Virtual Machine."
}

# data nodes min count
variable "apigee_data_pool_min_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

# data nodes max count
variable "apigee_data_pool_max_node_count" {
  type          = number
  description   = "The minimum number of nodes which should exist in this Node Pool. Once created, this value cannot be changed."
  
}

###################################################
# Azure Container Registry
###################################################

# Azure Container Registry subnet address space
variable "acr_subnet_address_prefixes" {
  type          = list(string)
  description   = "The list of IP address spaces for subnets in the virtual network."
}

# Azure Container Registry SKU 
variable "acr_sku" {
  type          = string
  description   = "The SKU of the Azure Container Registry."
}

# Azure Container Registry Admin User Enabled
variable "acr_admin_enabled" {
  type          = bool
  description   = "Specifies whether the admin user is enabled."
}

# Azure Container Registry Geo Replication Location
variable "acr_geo_replication_locations" {
  type          = list(string)
  description   = "A list of Azure locations where the container registry should be geo-replicated."
}

# Azure Container Registry log analytics retention in days
variable "acr_log_analytics_retention_days" {
  type          = number
  description   = "The number of days to retain log data for the container registry."
}

# Azure Container Registry data endpoint enabled
variable "acr_data_endpoint_enabled" {
  type          = bool
  description   = "Specifies whether the data endpoint is enabled."
}

###################################################
# Azure Key Vault
###################################################

# Azure Key Vault subnet address space
variable "akv_subnet_address_prefixes" {
  type          = list(string)
  description   = "The list of IP address spaces for subnets in the virtual network."
}

# Azure Key Vault SKU
variable "akv_sku" {
  type    = string
  default = "standard"
}
# Azure Key Vault Enabled for Disk Encryption
variable "akv_for_disk_encryption_enabled" {
  type          = bool
  description   = "Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault."
  
}

# Azure Key Vault Deployment
variable "akv_for_deployment_enabled" {
  type          = bool
  description   = "Specifies whether Azure Resource Manager is permitted to retrieve secrets from the vault."
}

# Azure Key Vault Template Deployment
variable "akv_template_deployment_enabled" {
  type          = bool
  description   = "Specifies whether the Azure Key Vault is enabled for template deployment."
}

# Azure Key Vault Soft Delete
variable "akv_soft_delete_enabled" {
  type          = bool
  description   = "Specifies whether the soft delete functionality is enabled for this key vault."
}  

# Azure Key Vault Purge Protection
variable "akv_purge_protection_enabled" {
  type          = bool
  description   = "Specifies whether the 'soft delete' functionality is enabled for this key vault."
}

# Resource Group Name
variable "resource_group_name" {
  type          = string
  description   = "The Resource Group that exists"
}

# Resource Group Name
variable "resource_group_location" {
  type          = string
  description   = "The Resource Group location"
}

# Resource Group ID
variable "resource_group_id" {
  type          = string
  description   = "The Resource Group ID"
}

# Azure Application Gateway 
variable "app_gateway_name" {
  type          = string
  description   = "The Application Gateway name"
}

# Azure Application Gateway Subnet
variable "app_gateway_subnet_cidr" {
  type          = string
  description   = "The App gateway subnet"
}

