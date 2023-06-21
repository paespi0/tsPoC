tenant_id           = ""
cluster_name        = "ts-cluster"
dns_prefix          = "truckstop-aks"
resource_group_name = "truckstop-aks-rg" # Set the resource group name
location            = "East US"          # Set the Azure location (e.g., "East US", "West Europe", etc.)
kubernetes_version  = "1.25.6"           # Set the Kubernetes version for the AKS cluster
node_pool_name      = "default"          # Set the name of the default node pool
node_count          = 3                  # Set the number of nodes in the default node pool
vm_size             = "Standard_DS2_v2"  # Set the VM size for the nodes in the default node pool
kv_rg_name          = "truckstop-kv-rg"
key_vault_name      = "ts-kv"

aks_cluster_resource_group_name = "truckstop-aks-rg"
aks_cluster_name                = "ts-cluster"
key_vault_resource_group_name   = "truckstop-kv-rg"
kv_secret_name                  = "test-tsservice-examplesecret"
sample_app_image                = "paespi0/nginx-aks-keyvault-sample"
namespace                       = "ts-namespace"
