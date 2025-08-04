variable "name" {
  description = "name"
  type = string
}

variable "resource_group_name" {
  description = "name"
  type = string
}
variable "location" {
  description = "location"
  type = string
  default= "East US"
}

variable "sku" {
  description = "sku"
  type = string
  default = "Standard"
  
}

variable "admin_enabled" {
  description="enable admin access"
  type = bool
  default = true
}