variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "node_count" {
  default = 1
}
variable "vm_size" {
  default = "Standard_B2s_v2"
}
