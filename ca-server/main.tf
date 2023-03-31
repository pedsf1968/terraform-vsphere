resource "vsphere_virtual_machine" "root_ca_vm" {
  depends_on = [
    data.vsphere_datacenter.datacenter,
    data.vsphere_compute_cluster.cluster,
    data.vsphere_virtual_machine.vm_template,
    data.vsphere_datastore.vm_template_datastore,
    data.vsphere_network.vm_template_network,
    data.vsphere_datastore.vm_datastore,
    data.vsphere_network.vm_network
  ]

  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.vm_datastore.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type

  name             = "${var.root_ca_vm.name}"
  num_cpus         = "${var.root_ca_vm.num_cpus}"
  memory           = "${var.root_ca_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.root_ca_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.root_ca_vm.hostname}"
        domain    = var.root_ca_vm.domain
        time_zone = var.root_ca_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.root_ca_vm.ipv4_ip}"
        ipv4_netmask = var.root_ca_vm.ipv4_netmask
      }
      ipv4_gateway = var.root_ca_vm.ipv4_gateway
      dns_server_list = var.root_ca_vm.dns_server_list
    }
  }
}

output "root_ca_vm_info" {
  value = {
      ip = vsphere_virtual_machine.root_ca_vm.default_ip_address
      memory = vsphere_virtual_machine.root_ca_vm.memory
      num_cpus = vsphere_virtual_machine.root_ca_vm.num_cpus
  }
}

resource "vsphere_virtual_machine" "sub_ca_vm" {
  depends_on = [
    data.vsphere_datacenter.datacenter,
    data.vsphere_compute_cluster.cluster,
    data.vsphere_virtual_machine.vm_template,
    data.vsphere_datastore.vm_template_datastore,
    data.vsphere_network.vm_template_network,
    data.vsphere_datastore.vm_datastore,
    data.vsphere_network.vm_network
  ]

  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.vm_datastore.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type

  name             = "${var.sub_ca_vm.name}"
  num_cpus         = "${var.sub_ca_vm.num_cpus}"
  memory           = "${var.sub_ca_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.sub_ca_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.sub_ca_vm.hostname}"
        domain    = var.sub_ca_vm.domain
        time_zone = var.sub_ca_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.sub_ca_vm.ipv4_ip}"
        ipv4_netmask = var.sub_ca_vm.ipv4_netmask
      }
      ipv4_gateway = var.sub_ca_vm.ipv4_gateway
      dns_server_list = var.sub_ca_vm.dns_server_list
    }
  }
}

output "sub_ca_vm_info" {
  value = {
      ip = vsphere_virtual_machine.sub_ca_vm.default_ip_address
      memory = vsphere_virtual_machine.sub_ca_vm.memory
      num_cpus = vsphere_virtual_machine.sub_ca_vm.num_cpus
  }
}