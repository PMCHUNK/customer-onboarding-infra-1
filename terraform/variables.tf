variable "resource_group_name" {
  description = "name"
  type = string
  default = "customer-onboarding-rg"
}

variable "location" {
    description = "location"
    type = string
    default="Central India"
  
}

variable "storage_account_name" {
    type = string
    default="s00181storage"
}

variable "key_vault_name" {
  type = string
  default = "s00181kvna2"
}

variable "db_password" {
  type = string
  default = "Abhi@123"
}

variable "db_name" {
  type = string
  default = "customer_db"
}

variable "db_server_name" {
  type = string
  default = "customer-pg-db0"
  
}