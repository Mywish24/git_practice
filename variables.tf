variable "resource_group_name" {
  type        = string
  description = "RG name "
}

variable "location" {
  type        = string
  description = "RG location "
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account name "
}

variable "storage_container_name" {
  type        = string
  description = "Storage Container name "
}

variable "vnetCIDR" {
  description = "VNET CIDR"
  type        = list
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  type        = list
  default     = ["10.0.0.4", "10.0.0.5"]
} 

variable "prefix" {
}

variable "username" {
  type        = string
}

variable "webCIDR" {
    type = list 
    default     = ["10.0.1.0/24"]
}