<!-- BEGIN_TF_DOCS -->

# Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.6 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.1.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks-cluster"></a> [aks-cluster](#module\_aks-cluster) | ./aks-cluster | n/a |
| <a name="module_key-vault"></a> [key-vault](#module\_key-vault) | ./key-vault | n/a |
| <a name="module_kubernetes-config"></a> [kubernetes-config](#module\_kubernetes-config) | ./kubernetes-config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | The name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_aks_cluster_resource_group_name"></a> [aks\_cluster\_resource\_group\_name](#input\_aks\_cluster\_resource\_group\_name) | The name of the resource group containing the AKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix | `string` | `"truckstop-aks"` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the Azure Key Vault. | `string` | n/a | yes |
| <a name="input_key_vault_resource_group_name"></a> [key\_vault\_resource\_group\_name](#input\_key\_vault\_resource\_group\_name) | The name of the resource group containing the Azure Key Vault. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version | `string` | `"1.25.6"` | no |
| <a name="input_kv_rg_name"></a> [kv\_rg\_name](#input\_kv\_rg\_name) | Define the name of the resource group for the Azure Key Vault | `string` | n/a | yes |
| <a name="input_kv_secret_name"></a> [kv\_secret\_name](#input\_kv\_secret\_name) | Define the name of the secret in the Azure Key Vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | `"eastus2"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Node count | `number` | `3` | no |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | Node pool name | `string` | `"tsnodepool1"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"truckstop-aks-rg"` | no |
| <a name="input_sample_app_image"></a> [sample\_app\_image](#input\_sample\_app\_image) | The container image for the sample application | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID for your Azure Active Directory account | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | VM size | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_workers_count"></a> [workers\_count](#input\_workers\_count) | Define the number of worker nodes for the AKS cluster | `string` | `"3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Output the name of the created AKS cluster. This can be used by other resources or modules that need to reference the cluster. |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Output the name of the created Azure Key Vault. This can be used by other resources or modules that need to reference the Key Vault. |
<!-- END_TF_DOCS -->