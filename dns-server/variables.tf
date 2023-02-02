variable "vsphere" {
  type = object({
    server = string
    datacenter = string
    compute_cluster = string
  })
  default = { 
    server = "10.1.55.3"
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

################################################################# DNS PARAMETERS
variable vsphere_vm {
  type = object({
    datastore = string  # vsphere datastore
    network = string    # vsphere network
  })
  default = {
    datastore = "Datastore-04-Raid5"
    network = "DMZ"
  }
}

variable "dns_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_address = string
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string)
  })

  default = {
    name = "ns1-server"
    hostname = "ns1-server"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 2
    memory = 2048
    disk_size = 16
    ipv4_address = "10.1.77.25"
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.77.254"
    dns_server_list = ["10.1.77.15", "8.8.8.8"]
  }
}