resource "vsphere_virtual_machine" "proxy_vm" {
  depends_on = [
    data.vsphere_datacenter.datacenter,
    data.vsphere_compute_cluster.cluster,
    data.vsphere_datastore.datastore_template,
    data.vsphere_datastore.datastore_vm,
    data.vsphere_network.network_template,
    data.vsphere_network.network_vm,
    data.vsphere_virtual_machine.template
  ]

  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore_vm.id}"
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.template.scsi_type}"

  name             = "${var.proxy_vm.name}"
  num_cpus         = "${var.proxy_vm.num_cpus}"
  memory           = "${var.proxy_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.network_vm.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.proxy_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.datastore_vm.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {      
      linux_options {
        host_name = "${var.proxy_vm.hostname}"
        domain    = var.proxy_vm.domain
      }
      network_interface {
        ipv4_address = "${var.proxy_vm.ipv4_address}"
        ipv4_netmask = var.proxy_vm.ipv4_netmask
      }
      ipv4_gateway = var.proxy_vm.ipv4_gateway
      
    }
  }
}


output "proxy_server_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.proxy_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

