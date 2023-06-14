output "cluster_name" {
    description = "The name of the created AKS cluster"
    value = azurerm_kubernetes_cluster.myAKSCluster.name
}

output "cluster_rg" {
    description = "The name of the created AKS cluster resource group"
    value = azurerm_resource_group.aks.name
}