

resource "vsphere_virtual_machine" "dns_vm" {
  depends_on = [
    data.vsphere_datacenter.datacenter,
    data.vsphere_compute_cluster.cluster,
    data.vsphere_virtual_machine.vm_template,
    data.vsphere_datastore.vm_template_datastore,
    data.vsphere_network.vm_template_network,
    data.vsphere_datastore.vm_datastore,
    data.vsphere_network.vm_network,
  ]

  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.vm_datastore.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type


  name             = var.dns_vm.name
  num_cpus         = var.dns_vm.num_cpus
  memory           = var.dns_vm.memory
  
  network_interface {
    network_id   = data.vsphere_network.vm_network.id
    adapter_type = data.vsphere_virtual_machine.vm_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.dns_vm.disk_size
    thin_provisioned = data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned
    datastore_id     = data.vsphere_datastore.vm_datastore.id 
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
    
    customize {      
      linux_options {
        host_name = var.dns_vm.hostname
        domain    = var.dns_vm.domain
        time_zone = var.dns_vm.time_zone
      }
      network_interface {
        ipv4_address = var.dns_vm.ipv4_address
        ipv4_netmask = var.dns_vm.ipv4_netmask
      }
      ipv4_gateway = var.dns_vm.ipv4_gateway
      dns_server_list = var.dns_vm.dns_server_list
    }
  }
}

output "dns_vm_info" {
  value = {
    ip = vsphere_virtual_machine.dns_vm.default_ip_address
    memory = vsphere_virtual_machine.dns_vm.memory
    num_cpus = vsphere_virtual_machine.dns_vm.num_cpus
  }
}