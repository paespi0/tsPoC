# Define the Kubernetes version to be used for the AKS cluster
variable "kubernetes_version" {
  description = "Kubernetes version"
  default     = "1.25.6"
}

# Define the number of worker nodes for the AKS cluster
variable "workers_count" {
  default = "3"
}

# Define the name of the AKS cluster
variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

# Define the name of the Azure resource group where the AKS cluster will be created
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "truckstop-aks-rg"
}

# Define the name of the resource group containing the AKS cluster
variable "aks_cluster_resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  type        = string
}

# Define the name of the AKS cluster
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

# Define the DNS prefix for the AKS cluster
variable "dns_prefix" {
  description = "DNS prefix"
  type        = string
  default     = "truckstop-aks"
}

# Define the name of the node pool for the AKS cluster
variable "node_pool_name" {
  description = "Node pool name"
  type        = string
  default     = "tsnodepool1"
}

# Define the number of nodes in the node pool for the AKS cluster
variable "node_count" {
  description = "Node count"
  type        = number
  default     = 3
}

# Define the size of the VMs in the node pool for the AKS cluster
variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_DS2_v2"
}

# Define the Azure region where the AKS cluster will be created
variable "location" {
  description = "Location"
  type        = string
  default     = "eastus2"
}

# Define the tenant ID for your Azure Active Directory account
variable "tenant_id" {
  description = "The tenant ID for your Azure Active Directory account"
  type        = string
}

# Define the name of the resource group for the Azure Key Vault
variable "kv_rg_name" {
  type = string
}

# Define the name of the resource group containing the Azure Key Vault
variable "key_vault_resource_group_name" {
  description = "The name of the resource group containing the Azure Key Vault."
  type        = string
}

# Define the name of the Azure Key Vault
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

# Define the container image for the sample application
variable "sample_app_image" {
  description = "The container image for the sample application"
  type        = string
}

# Define the name of the secret in the Azure Key Vault
variable "kv_secret_name" {
  type = string
}

# Define the Kubernetes namespace where the sample application will be deployed
variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}
