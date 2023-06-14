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

# Define the input variable for the Key Vault's resource group name
# with a description and type
variable "key_vault_resource_group_name" {
  description = "The name of the resource group containing the Azure Key Vault."
  type        = string
}

# Define the input variable for the Key Vault's name
# with a description and type
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

#  variable "subscription_id" {
#    description = "The subscription ID for your Azure account"
#    type        = string
#  }

# variable "tenant_id" {
#   description = "The tenant ID for your Azure Active Directory account"
#   type        = string
# }

# variable "sample_app_image" {
#   description = "The container image for the sample application"
#   type        = string
# }

variable "kv_secret_name" {
  type = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "kubeconfig" {
  type = string
}

# variable "aks_resource_group_name" {
#   description = "The name of the resource group where the AKS cluster is created"
#   type        = string
# }

# variable "kv_resource_group_name" {
#   description = "The name of the resource group where the Key Vault is created"
#   type        = string
# }
