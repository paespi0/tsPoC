// Retrieves information about the currently authenticated Azure account
// This is useful when you need to access details of the current Azure account (e.g., subscription ID, tenant ID, etc.) in your Terraform configuration
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "myKeyVaultResourceGroup" {
  name     = var.kv_rg_name
  location = var.location
}

resource "random_integer" "key_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_key_vault" "myKeyVault" {
  depends_on = [
    azurerm_resource_group.myKeyVaultResourceGroup
  ]
  name                = "${var.key_vault_name}${random_integer.key_suffix.result}"
  location            = azurerm_resource_group.myKeyVaultResourceGroup.location
  resource_group_name = azurerm_resource_group.myKeyVaultResourceGroup.name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  tags = {
    Terraform = "true"
  }
}

# Define a data block to reference an existing Azure Kubernetes Service (AKS) cluster
# This data block fetches information about the specified AKS cluster, such as its tenant ID
data "azurerm_kubernetes_cluster" "existing" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_cluster_resource_group_name
}

data "azurerm_user_assigned_identity" "aksSP_id" {
  # name                = "${data.azurerm_kubernetes_cluster.existing.name}-agentpool"
  name                = "azureKeyvaultSecretsProvider-${data.azurerm_kubernetes_cluster.existing.name}"
  resource_group_name = data.azurerm_kubernetes_cluster.existing.node_resource_group
}


# Define a resource block to create an access policy for the AKS cluster to access the Key Vault
# This access policy allows the AKS cluster to read secrets from the Key Vault
resource "azurerm_key_vault_access_policy" "aks" {
  # Reference the existing Key Vault's ID to apply the access policy
  key_vault_id = azurerm_key_vault.myKeyVault.id

  # Use the tenant ID from the existing AKS cluster
  tenant_id = data.azurerm_kubernetes_cluster.existing.identity[0].tenant_id
  # Use the principal ID of the user-assigned managed identity for the AKS cluster
  #object_id = data.azurerm_user_assigned_identity.aks_id.client_id
  # object_id = data.azurerm_kubernetes_cluster.existing.key_vault_secrets_provider[0].secret_identity[0].client_id
  object_id = data.azurerm_user_assigned_identity.aksSP_id.principal_id

  # Allow the AKS cluster to get and list keys from the Key Vault, enabling it to read the keys
  key_permissions = ["Get", "List"]
  # Allow the AKS cluster to get and list secrets from the Key Vault, enabling it to read the secrets
  secret_permissions = ["Get", "List"]
  # Allow the AKS cluster to get and list certs from the Key Vault, enabling it to read the certs
  certificate_permissions = ["Get", "List"]
}

# Define a resource block to create an access policy for the current user to access the Key Vault
# This access policy allows the AKS cluster to read secrets from the Key Vault
resource "azurerm_key_vault_access_policy" "current" {
  depends_on = [azurerm_key_vault.myKeyVault]
  # Reference the existing Key Vault's ID to apply the access policy
  key_vault_id = azurerm_key_vault.myKeyVault.id

  # Use the tenant ID from the existing AKS cluster
  tenant_id = data.azurerm_client_config.current.tenant_id
  # Use the principal ID of the user-assigned managed identity for the AKS cluster
  object_id = data.azurerm_client_config.current.object_id


  # Allow the AKS cluster to get and list keys from the Key Vault, enabling it to read the keys
  key_permissions = ["Create", "Get", "List", "Rotate", "Delete", "Purge", "Update", "SetRotationPolicy", "GetRotationPolicy"]
  # Allow the AKS cluster to get and list secrets from the Key Vault, enabling it to read the secrets
  secret_permissions = ["Get", "Set", "List", "Delete", "Purge"]
  # Allow the AKS cluster to get and list certs from the Key Vault, enabling it to read the certs
  certificate_permissions = ["Create", "Get", "List"]
}

resource "azurerm_key_vault_secret" "example_secret" {
  depends_on   = [azurerm_key_vault.myKeyVault, azurerm_key_vault_access_policy.current]
  name         = "test-tsservice-examplesecret"
  value        = "ts-secret-value"
  key_vault_id = azurerm_key_vault.myKeyVault.id
}

resource "azurerm_key_vault_key" "example_key" {
  depends_on   = [azurerm_key_vault.myKeyVault, azurerm_key_vault_access_policy.current]
  name         = "test-tsservice-examplekey"
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt"]
  key_vault_id = azurerm_key_vault.myKeyVault.id

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}