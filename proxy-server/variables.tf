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

variable "vsphere_datacenter" {
  type = string
  description = "Datacenter name"
  default = "datacenter-01"
}

variable "vsphere_compute_cluster" {
  type = string
  description = "cluster name"
  default = "cluster-01"
}

############################################################ TEMPLATE PARAMETERS
variable "template_name" {
  type = string
  description = "Name of the template to buid the new VM"
  default = "T-Ubuntu-22-04-1-srv"
}

variable "vsphere_datastore_template" {
  type = string
  description = "Datastore template name"
  default = "Datastore-01-Raid0"
}

variable "vsphere_network_template" {
  type = string
  description = "vSphere template network"
  default = "SIS"
}

################################################################## VM PARAMETERS
variable "vsphere_datastore_vm" {
  type = string
  description = "Datastore VM name"
  default = "Datastore-04-Raid5"
}

variable "vsphere_folder_vm" {
  type = string
  description = "vSphere VM folder"
  default = "SYSTEM"
}

variable "vsphere_network_vm" {
  type = string
  description = "vSphere VM network"
  default = "DMZ"
}

# VM IP is prefix+start
variable "proxy_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_address = string
    ipv4_netmask = string
    ipv4_gateway = string 
  })

  default = {
    name = "proxy-server"
    hostname = "proxy-server"
    domain = "hawkfund.kr"
    num_cpus = 4
    memory = 4096
    disk_size = 100
    ipv4_address = "10.1.77.15"
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.77.254"
  }
}
