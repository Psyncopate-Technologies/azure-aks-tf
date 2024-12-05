# terraform.tfvars
tenant_id                                   = "<Tenant ID>"
subscription_id                             = "<Subscription ID>"
dev_ops_group_id                            = "<SP Object ID>"
resource_group_name                         = "<RG Name>"
resource_group_location                     = "eastus"
resource_group_id                           = "/subscriptions/<Subscription ID>/resourceGroups/<RG Name>"
# SDLC settings 
appname                                     = "flink-poc"
env                                         = "stg"
loc                                         = "dc04"
owner                                       = "psyncopate"
region                                      = "eastus"
virtual_network_address_spaces              = ["10.115.50.0/23", "10.115.52.0/23"]

# Azure Kubernetes Service (AKS)
aks_subnet_address_prefixes                 = ["10.115.52.0/23"]
aks_service_principal_id                    = "<SP Application ID>"
aks_service_principal_secret                = "<Clinet Secret>"
aks_kubernetes_version                      = "1.29"

# Azure Application Gateway
app_gateway_name                            = "aks-flink-gateway"
app_gateway_subnet_cidr                     = "10.225.0.0/16"

# default pool
default_pool_name                           = "agentpool"
default_pool_node_count                     = 2
default_pool_node_vm_size                   = "Standard_DS3_v2"
default_pool_node_os_disk_size_gb           = 30
default_pool_min_node_count                 = 2
default_pool_max_node_count                 = 4

# rtf pool
rtf_pool_name                               = "rtfpool"
rtf_pool_node_count                         = 2
rtf_pool_node_vm_size                       = "Standard_DS2_v2"
rtf_pool_node_os_disk_size_gb               = 30
rtf_pool_min_node_count                     = 2
rtf_pool_max_node_count                     = 4

# apigee runtime pool
apigee_runtime_pool_name                    = "apgruntime"
apigee_runtime_pool_node_count              = 2
apigee_runtime_pool_node_vm_size            = "Standard_DS2_v2"
apigee_runtime_pool_node_os_disk_size_gb    = 30
apigee_runtime_pool_min_node_count          = 2
apigee_runtime_pool_max_node_count          = 4


# apigee datat pool
apigee_data_pool_name                       = "flinkpocnp"
apigee_data_pool_node_count                 = 2
apigee_data_pool_node_vm_size               = "Standard_D4s_v3"
apigee_data_pool_node_os_disk_size_gb       = 30
apigee_data_pool_min_node_count             = 2
apigee_data_pool_max_node_count             = 4

# Azure Container Registry (ACR)
acr_subnet_address_prefixes                 = ["10.115.50.32/28"]
acr_sku                                     = "Basic"
acr_admin_enabled                           = true
acr_geo_replication_locations               = ["eastus"]
acr_log_analytics_retention_days            = 7
acr_data_endpoint_enabled                   = true


# Azure Key Vault (AKV)
akv_subnet_address_prefixes                 = ["10.115.50.16/28"]
akv_sku                                     = "standard"
akv_for_disk_encryption_enabled             = true
akv_for_deployment_enabled                  = true
akv_template_deployment_enabled             = true
akv_purge_protection_enabled                = true
akv_soft_delete_enabled                     = true