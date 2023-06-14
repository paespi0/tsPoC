# Output the name of the created AKS cluster. This can be used by other resources or modules that need to reference the cluster.
output "cluster_name" {
  value = var.cluster_name
}

# Output the name of the created Azure Key Vault. This can be used by other resources or modules that need to reference the Key Vault.
output "key_vault_name" {
  value = var.key_vault_name
}
