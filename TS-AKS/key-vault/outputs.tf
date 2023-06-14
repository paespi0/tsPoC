output "key_vault_id" {
  value = azurerm_key_vault.myKeyVault.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.myKeyVault.vault_uri
}

output "key_vault_name" {
  description = "The name of the created Key Vault"
  value = azurerm_key_vault.myKeyVault.name
}

output "key_vault_rg" {
  description = "The name of the created Key Vault resource group"
  value = azurerm_resource_group.myKeyVaultResourceGroup.name
}

output "key_secret_name" {
  description = "The name of the created Key Vault secret"
  value = azurerm_key_vault_secret.example_secret.name
}

