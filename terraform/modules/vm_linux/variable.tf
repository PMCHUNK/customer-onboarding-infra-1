variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_name" {
  type = string
  default = "db-vm"
}

variable "vm_password" {
  type = string
  sensitive = true
  default = "Abhi@123"
}

variable "user_name" {
  type = string
  default = "abhim"
}

variable "network_interface_ids" {
  type = string
}