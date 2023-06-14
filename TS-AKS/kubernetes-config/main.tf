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
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

resource "kubernetes_namespace" "test" {
  provider = kubernetes
  metadata {
    name = var.namespace //"ts-namespace"
  }
}

# Define a data block to reference an existing Azure Kubernetes Service (AKS) cluster
# This data block fetches information about the specified AKS cluster, such as its tenant ID
data "azurerm_kubernetes_cluster" "existing" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_cluster_resource_group_name
}

// Retrieves information about the currently authenticated Azure account
// This is useful when you need to access details of the current Azure account (e.g., subscription ID, tenant ID, etc.) in your Terraform configuration
data "azurerm_client_config" "current" {}

resource "local_file" "kube_config" {
  content  = var.kubeconfig
  filename = "${path.root}/kubeconfig"
}

data "local_file" "kube_config_data" {
  depends_on = [local_file.kube_config]
  filename = "${path.root}/kubeconfig"
}

locals {
  aks_oidc_issuer = data.azurerm_kubernetes_cluster.existing.oidc_issuer_url
   kube_config = yamldecode(data.local_file.kube_config_data.content)
   api_server_url = local.kube_config.clusters[0].cluster.server
}

data "azurerm_user_assigned_identity" "aksSP_id" {
  name                = "azurekeyvaultsecretsprovider-${data.azurerm_kubernetes_cluster.existing.name}"
  resource_group_name = data.azurerm_kubernetes_cluster.existing.node_resource_group
}

resource "kubectl_manifest" "secret-provider-class" {
  provider = kubectl

  yaml_body = templatefile(
    "${path.module}/deploy/secret-provider-class.yaml"
    ,
    { tenantId                = "\"${data.azurerm_kubernetes_cluster.existing.identity.0.tenant_id}\"",
      keyVaultName            = var.key_vault_name,
      kvsp_aks                = "\"${data.azurerm_user_assigned_identity.aksSP_id.principal_id}\""
  })
}

resource "kubectl_manifest" "service-account" {
  provider = kubectl

  yaml_body = templatefile(
    "${path.module}/deploy/service-account.yaml"
    ,
    { svc_acct_name           = "\"${data.azurerm_user_assigned_identity.aksSP_id.name }\"",
      kvsp_aks                = "\"${data.azurerm_user_assigned_identity.aksSP_id.principal_id}\""
      svc_acct_namespace      =  kubernetes_namespace.test.metadata[0].name
  })
}

resource "azuread_application" "example" {
  display_name = "example"
}

resource "azuread_application_federated_identity_credential" "example" {
  application_object_id = azuread_application.example.object_id
  display_name          = data.azurerm_user_assigned_identity.aksSP_id.name //"ts-fed-identity-cred"
  description           = "PoC for using fed id cred as workload identity for AKS"
  # audiences             = ["api://AzureADTokenExchange"]
  audiences             = [local.api_server_url]
  issuer                = local.aks_oidc_issuer //"https://token.actions.githubusercontent.com"
  # subject               = "repo:my-organization/my-repo:environment:prod"
  # subject               = "system:serviceaccount:my-namespace:my-serviceaccount"
  subject               = "system:serviceaccount:${kubernetes_namespace.test.metadata[0].name}:${data.azurerm_user_assigned_identity.aksSP_id.name}"
}

resource "kubectl_manifest" "ts-pod" {
  depends_on = [
    kubectl_manifest.secret-provider-class
  ]
  provider = kubectl
  yaml_body = templatefile("${path.module}/deploy/pod.yaml", {})
}

# Define a data block to reference an existing Azure Key Vault
# This data block fetches information about the specified Key Vault, such as its ID and URI
data "azurerm_key_vault" "existing" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

resource "kubectl_manifest" "workload-pod" {
  provider = kubectl

  yaml_body = templatefile(
    "${path.module}/deploy/workloadpod.yaml"
    ,
    { kv_uri                  = data.azurerm_key_vault.existing.vault_uri,  
      kv_secret_name          = var.kv_secret_name,
      svc_acct_name           = "\"${data.azurerm_user_assigned_identity.aksSP_id.name }\"",
      svc_acct_namespace      = kubernetes_namespace.test.metadata[0].name
  })
}

locals {
  app_label = "tssample-app"
}

