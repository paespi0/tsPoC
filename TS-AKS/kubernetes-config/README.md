# AKS and Azure Key Vault Integration Terraform Module

This Terraform module integrates an existing Azure Kubernetes Service (AKS) cluster with an existing Azure Key Vault. It allows pods running in the AKS cluster to access secrets stored in the Key Vault.

## Prerequisites

- Terraform v1.0 or higher
- Azure CLI
- An existing Azure Kubernetes Service (AKS) cluster
- An existing Azure Key Vault

## Usage

To use this module in your Terraform configuration, add the following code:

```hcl
module "aks_keyvault_integration" {
  source = "path/to/aks_keyvault_integration"

  aks_cluster_resource_group_name = "<aks_cluster_resource_group_name>"
  aks_cluster_name                = "<aks_cluster_name>"
  key_vault_resource_group_name   = "<key_vault_resource_group_name>"
  key_vault_name                  = "<key_vault_name>"
  aks_service_principal_id        = "<aks_service_principal_id>"
}

Replace the placeholders with the appropriate values:

<aks_cluster_resource_group_name>: The name of the resource group containing the AKS cluster.
<aks_cluster_name>: The name of the AKS cluster.
<key_vault_resource_group_name>: The name of the resource group containing the Azure Key Vault.
<key_vault_name>: The name of the Azure Key Vault.
<aks_service_principal_id>: The service principal ID for the AKS cluster.

Inputs
Name	Description	Type
aks_cluster_resource_group_name	The name of the resource group containing the AKS cluster.	string
aks_cluster_name	The name of the AKS cluster.	string
key_vault_resource_group_name	The name of the resource group containing the Azure Key Vault.	string
key_vault_name	The name of the Azure Key Vault.	string
aks_service_principal_id	The service principal ID for the AKS cluster.	string

Outputs
Name	Description
key_vault_id	The ID of the Azure Key Vault.
aks_cluster_id	The ID of the AKS cluster.
Additional Information
For more information on AKS and Azure Key Vault, please refer to the following documentation:

Azure Kubernetes Service (AKS)
Azure Key Vault


Make sure to replace the `source` path with the actual path to your module if it is stored locally or a Git URL if it is stored in a Git repository.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.1.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0.3 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [kubectl_manifest.secret-provider-class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.service-account](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.ts-pod](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.workload-pod](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.test](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [local_file.kube_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_user_assigned_identity.aksSP_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [local_file.kube_config_data](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | The name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_aks_cluster_resource_group_name"></a> [aks\_cluster\_resource\_group\_name](#input\_aks\_cluster\_resource\_group\_name) | The name of the resource group containing the AKS cluster. | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the Azure Key Vault. | `string` | n/a | yes |
| <a name="input_key_vault_resource_group_name"></a> [key\_vault\_resource\_group\_name](#input\_key\_vault\_resource\_group\_name) | The name of the resource group containing the Azure Key Vault. | `string` | n/a | yes |
| <a name="input_kubeconfig"></a> [kubeconfig](#input\_kubeconfig) | n/a | `string` | n/a | yes |
| <a name="input_kv_secret_name"></a> [kv\_secret\_name](#input\_kv\_secret\_name) | n/a | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->