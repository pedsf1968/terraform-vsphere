variable "vsphere_datacenter" {
  type = string
  description = "Datacenter name"
  default = "datacenter-01"
}

variable "vsphere_datastore" {
  type = string
  description = "Datastore name"
  default = "Datastore-01-Raid0"
}

variable "vsphere_compute_cluster" {
  type = string
  description = "cluster name"
  default = "cluster-01"
}

variable "vsphere_server" {
  type = string
  description = "vSphere server IP"
  default = "10.1.55.3"
}

variable "vsphere_user" {
  type = string
  description = "vSphere user login"
  default = "administrator@hawkfund.kr"
}

variable "vsphere_password" {
  type = string
  description = "vSphere user password"
  default = "Yido1418$"
}

variable "template_name" {
  type = string
  description = "Name of the template to buid the new VM"
  default = "T-Ubuntu-22-04-1-srv"
}

################################################################## VM PARAMETERS
variable "vm_name" {
  type = string
  description = "Name of the VM"
  default = "Hello"
}

variable "vm_hostname" {
  type = string
  description = "Hostname of the VM"
  default = "hello"
}

variable "vm_domain" {
  type = string
  description = "Domain of the VM"
  default = "hawkfund.kr"
}

variable "vm_num_cpus" {
  type = number
  description = "Number of CPU cores of the VM"
  default = 2
}

variable "vm_memory" {
  type = number
  description = "Size of the memory of the VM in Mo"
  default = 2048
}

variable "vm_disk_size" {
  type = number
  description = "Size of the memory of the VM in Mo"
  default = 50
}

##################################################################### VM NETWORK
variable "vsphere_network" {
  type = string
  description = "vSphere network"
  default = "SIS"
}

variable "vm_ipv4" {
  type = string
  description = "IPv4 of the VM"
  default = "10.1.55.100"
}

variable "vm_ipv4_netmask" {
  type = string
  description = "Netmask of the VM"
  default = "24"
}

variable "vm_ipv4_gateway" {
  type = string
  description = "Gateway of the VM"
  default = "10.1.55.254"
}

