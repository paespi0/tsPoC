variable "kubernetes_version" {
  description = "Kubernetes version"
  default     = "1.25.6"
}

variable "workers_count" {
  default = "3"
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "tsAKScluster"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "truckstop-aks-rg"
}

variable "dns_prefix" {
  description = "DNS prefix"
  type        = string
  default     = "truckstop-aks"
}

variable "node_pool_name" {
  description = "Node pool name"
  type        = string
  default     = "tsnodepool1"
}

variable "node_count" {
  description = "Node count"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "location" {
  description = "Location"
  type        = string
  default     = "eastus2"
}

variable "tenant_id" {
  description = "The tenant ID for your Azure Active Directory account"
  type        = string
}