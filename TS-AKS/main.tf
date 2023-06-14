# Define the required providers and their versions
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.6"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

# Fetch the details of the existing AKS cluster
data "azurerm_kubernetes_cluster" "existing" {
  depends_on          = [module.aks-cluster] # refresh cluster state before reading
  name                = var.cluster_name # var.aks_cluster_name
  resource_group_name = var.aks_cluster_resource_group_name
}

# Configure the Kubernetes provider using the fetched AKS cluster details
provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.existing.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.cluster_ca_certificate)
}

# Configure the kubectl provider using the fetched AKS cluster details
provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.existing.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.cluster_ca_certificate)
  load_config_file       = false
}

# Configure the Helm provider using the fetched AKS cluster details
provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.existing.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.existing.kube_config.0.cluster_ca_certificate)
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Define the AKS cluster module
module "aks-cluster" {
  source = "./aks-cluster"

  resource_group_name = var.aks_cluster_resource_group_name # var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix
  node_pool_name      = var.node_pool_name
  node_count          = var.node_count
  vm_size             = var.vm_size
  tenant_id           = var.tenant_id
}

# Define the Kubernetes configuration module
module "kubernetes-config" {
  depends_on = [module.aks-cluster, module.key-vault]
  source     = "./kubernetes-config"

  providers = {
    kubectl    = kubectl
    kubernetes = kubernetes
  }
  aks_cluster_name                = module.aks-cluster.cluster_name
  aks_cluster_resource_group_name = module.aks-cluster.cluster_rg
  key_vault_name                  = module.key-vault.key_vault_name
  key_vault_resource_group_name   = module.key-vault.key_vault_rg
  kv_secret_name                  = module.key-vault.key_secret_name
  namespace                       = var.namespace
  kubeconfig                      = data.azurerm_kubernetes_cluster.existing.kube_config_raw
}

# Define the Key Vault module
module "key-vault" {
  source         = "./key-vault"
  kv_rg_name     = var.kv_rg_name
  location       = var.location
  key_vault_name = var.key_vault_name
  tenant_id      = var.tenant_id
  aks_cluster_resource_group_name = module.aks-cluster.cluster_rg
  aks_cluster_name                = module.aks-cluster.cluster_name

  depends_on = [module.aks-cluster]
}
