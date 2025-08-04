variable "vent_name" {
  description = "vnet_name"
  type = string
}

variable "address_space" {
  
  type = string
  description = "value"
  default = "10.10.0.0/16"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "aks_subnet_prefix" {
  type = string
  default = "10.10.1.0/24"
}

variable "db_subnet_prefix" {
  type = string
  default = "10.10.2.0/24"
}

variable "vm_subnet_prefix" {
  type = string
  default = "10.10.3.0/24"
}