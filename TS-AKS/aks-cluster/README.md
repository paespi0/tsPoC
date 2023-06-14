# Terraform Azure Kubernetes Service (AKS) Cluster Module

This module creates an Azure Kubernetes Service (AKS) cluster in Azure. It also creates an Azure Resource Group to host the AKS cluster and installs the AKS preview extension using Azure CLI.

## Prerequisites

Terraform v1.1.9 or newer
An Azure subscription
Azure CLI installed and configured with the appropriate permissions

## Providers

This module uses the following provider plugins:

azurerm (version ~>3.6)
You will need to configure the azurerm provider with your Azure tenant ID.

## Usage

hcl
Copy code
module "aks_cluster" {
  source = "./modules/aks-cluster"

  resource_group_name = "resource_group_name"
  location            = "location"
  cluster_name        = "cluster_name"
  kubernetes_version  = "kubernetes_version"
  dns_prefix          = "dns_prefix"
  node_pool_name      = "node_pool_name"
  node_count          = 3
  vm_size             = "vm_size"
}

## Inputs

Name Description Type Default
resource_group_name The name of the Azure Resource Group string "truckstop-aks-rg"
location The location/region in which to create the resources string "eastus2"
cluster_name The name of the AKS cluster string "truckstop-aks-cluster"
kubernetes_version The Kubernetes version to use for the AKS cluster string "1.25.6"
dns_prefix DNS prefix for the AKS cluster string "truckstop-aks"
node_pool_name The name of the default node pool string "tsnodepool1"
node_count The number of nodes in the default node pool number 3
vm_size The size of the virtual machines in the default node pool string "Standard_DS2_v2"

## Outputs

Name Description
kubeconfig_path The absolute path of the kubeconfig file
cluster_name The name of the AKS cluster

## Authors

This module was created by Pedro Espinoza

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.6 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.myAKSCluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [null_resource.aks_preview_extension](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | `"tsAKScluster"` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix | `string` | `"truckstop-aks"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version | `string` | `"1.25.6"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | `"eastus2"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Node count | `number` | `3` | no |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | Node pool name | `string` | `"tsnodepool1"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"truckstop-aks-rg"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID for your Azure Active Directory account | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | VM size | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_workers_count"></a> [workers\_count](#input\_workers\_count) | n/a | `string` | `"3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the created AKS cluster |
| <a name="output_cluster_rg"></a> [cluster\_rg](#output\_cluster\_rg) | The name of the created AKS cluster resource group |
<!-- END_TF_DOCS -->