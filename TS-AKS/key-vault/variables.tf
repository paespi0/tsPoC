variable "kv_rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "tenant_id" {
  description = "The tenant ID for your Azure Active Directory account"
  type        = string
}

# Define the input variable for the AKS cluster's resource group name
# with a description and type
variable "aks_cluster_resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  type        = string
}

# Define the input variable for the AKS cluster's name
# with a description and type
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}