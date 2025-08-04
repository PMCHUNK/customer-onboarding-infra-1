variable "key_vault_id" {
  description = "The ID of the Azure Key Vault"
  type        = string
}

variable "kubelet_identity" {
  description = "The object ID of the AKS kubelet managed identity"
  type        = string
}


variable "tenant_id" {
  description = "The tenant ID of the Azure Active Directory"
  type        = string
}

variable "object_id" {
  description = "The object ID of the managed identity (AKS kubelet identity)"
  type        = string
}


