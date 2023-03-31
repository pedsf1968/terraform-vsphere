variable "vsphere" {
  type = object({
    server = string
    datacenter = string
    compute_cluster = string
  })
  default = { 
    server = "vcenter.hawkfund.kr"
    datacenter = "datacenter-01"
    compute_cluster = "cluster-01"
  }
}

# Define TF_VAR_vsphere_user in your environment
variable "vsphere_user" { 
}

# Define TF_VAR_vsphere_password in your environment
variable "vsphere_password" { 
}


############################################################ TEMPLATE PARAMETERS
variable vsphere_template {
  type = object({
    name = string
    datastore = string
    network = string
  })
  default = {
    name = "T-Ubuntu-22-04-1-srv-stretch" # Name of the template to buid the new VM
    datastore = "Datastore-03-NoRaid"  # Datastore template name
    network = "SIS" # vSphere template network
  }
}


################################################################## VM PARAMETERS
variable vsphere_vm {
  type = object({
    datastore = string # vsphere datastore
    network = string  # vsphere network
  })
  default = {
    datastore = "Datastore-03-NoRaid"
    network = "SIS"
  }
}

variable "root_ca_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_ip = string
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string)
  })

  default = {
    name = "rootca"
    hostname = "rootca"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 1
    memory = 1024
    disk_size = 10
    ipv4_ip = "10.1.55.12"
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.66.254"
    dns_server_list = ["10.1.77.5", "10.1.77.6", "8.8.8.8"] 
  }
}

variable "sub_ca_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_ip = string
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string)
  })

  default = {
    name = "subca"
    hostname = "subca"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 1
    memory = 1024
    disk_size = 10
    ipv4_ip = "10.1.55.13"
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.66.254"
    dns_server_list = ["10.1.77.5", "10.1.77.6", "8.8.8.8"] 
  }
}
