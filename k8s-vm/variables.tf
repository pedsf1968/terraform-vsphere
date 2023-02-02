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


variable "controlplane_vm_count" {
  type = number
  description = "Number of controlplane nodes for k8s cluster"
  default = 5
}

variable "worker_vm_count" {
  type = number
  description = "Number of worker nodes for k8s cluster"
  default = 5
}

variable "api_lb_vm_count" {
  type = number
  description = "Number of load-balancer for controlplane api cluster"
  default = 2
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
    network = "CLOUD"
  }
}

# VM IP is prefix+start
variable "controlplane_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_prefix = string
    ipv4_start = number
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string) 
  })

  default = {
    name = "k8s-controlplane"
    hostname = "k8s-controlplane"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 4
    memory = 4096
    disk_size = 20
    ipv4_prefix = "10.1.66"
    ipv4_start = 41
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.66.254"
    dns_server_list = ["10.1.77.15", "8.8.8.8"] 
  }
}

variable "worker_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_prefix = string
    ipv4_start = number
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string) 
  })

  default = {
    name = "k8s-worker"
    hostname = "k8s-worker"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 4
    memory = 8192
    disk_size = 50
    ipv4_prefix = "10.1.66"
    ipv4_start = 51
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.66.254"
    dns_server_list = ["10.1.77.15", "8.8.8.8"] 
  }
}

variable "api_lb_vm" {
  type = object({
    name = string
    hostname = string
    domain = string
    time_zone = string
    num_cpus = number
    memory = number
    disk_size = number
    ipv4_prefix = string
    ipv4_start = number
    ipv4_netmask = string
    ipv4_gateway = string
    dns_server_list = list(string)
  })

  default = {
    name = "k8s-api-lb"
    hostname = "k8s-api-lb"
    domain = "hawkfund.kr"
    time_zone = "Europe/Paris"
    num_cpus = 2
    memory = 2048
    disk_size = 10
    ipv4_prefix = "10.1.66"
    ipv4_start = 21
    ipv4_netmask = "24"
    ipv4_gateway = "10.1.66.254"
    dns_server_list = ["10.1.77.15", "8.8.8.8"] 
  }
}
