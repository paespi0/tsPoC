terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.6"
      # version = "2.42"
    }
  }
}

resource "null_resource" "aks_preview_extension" {
  provisioner "local-exec" {
    command     = <<-EOT
      az extension add --upgrade --name aks-preview
    EOT
    interpreter = ["powershell", "-Command"]
  }
}

# Create a resource group for the AKS cluster
resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name # Use the provided resource group name
  location = var.location            # Use the provided location
}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "myAKSCluster" {
  depends_on = [
    null_resource.aks_preview_extension, azurerm_resource_group.aks
  ]

  name                = var.cluster_name        # Use the provided cluster name
  location            = var.location            # Use the provided location
  resource_group_name = var.resource_group_name # Use the provided resource group name

  # Configure Kubernetes version and DNS prefix
  kubernetes_version = var.kubernetes_version
  dns_prefix         = var.dns_prefix

  # az aks create -n aks -g myResourceGroup --enable-oidc-issuer
  oidc_issuer_enabled = true

  workload_identity_enabled = true

  #enabling Azure Key Vault Provider for Secrets Store CSI Driver
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  # Configure the default node pool
  default_node_pool {
    name       = var.node_pool_name # Use the provided node pool name
    node_count = var.node_count     # Use the provided node count
    vm_size    = var.vm_size        # Use the provided VM size
  }

  # Configure the AKS cluster identity
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}