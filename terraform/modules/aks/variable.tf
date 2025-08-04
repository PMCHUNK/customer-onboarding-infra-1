variable "aks_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
  default="customeronboarding"
}

variable "node_count" {
  type = number
  default = 1
}

variable "vm_size" {
  type = string
  default = "Standard_B1ms"
}

variable "aks_subnet_id" {
  type = string

}

variable "acr_id" {
  type = string
}