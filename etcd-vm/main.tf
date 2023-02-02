resource "vsphere_virtual_machine" "etcd_vm" {
  count = var.etcd_vm_count
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

  name             = "${var.etcd_vm.name}-${format("%02d", count.index+1)}"
  num_cpus         = "${var.etcd_vm.num_cpus}"
  memory           = "${var.etcd_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.etcd_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.etcd_vm.hostname}-${format("%02d", count.index+1)}"
        domain    = var.etcd_vm.domain
        time_zone = var.etcd_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.etcd_vm.ipv4_prefix}.${count.index + var.etcd_vm.ipv4_start}"
        ipv4_netmask = var.etcd_vm.ipv4_netmask
      }
      ipv4_gateway = var.etcd_vm.ipv4_gateway
      dns_server_list = var.etcd_vm.dns_server_list
      
    }
  }
}

resource "vsphere_virtual_machine" "etcd_lb_vm" {
  count = var.etcd_lb_vm_count
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

  name             = "${var.etcd_lb_vm.name}-${format("%02d", count.index+1)}"
  num_cpus         = "${var.etcd_lb_vm.num_cpus}"
  memory           = "${var.etcd_lb_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.etcd_lb_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.etcd_lb_vm.hostname}-${format("%02d", count.index+1)}"
        domain    = var.etcd_lb_vm.domain
        time_zone = var.etcd_lb_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.etcd_lb_vm.ipv4_prefix}.${count.index + var.etcd_vm.ipv4_start}"
        ipv4_netmask = var.etcd_lb_vm.ipv4_netmask
      }
      ipv4_gateway = var.etcd_lb_vm.ipv4_gateway
      dns_server_list = var.etcd_lb_vm.dns_server_list
    }
  }
}

output "etcd_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.etcd_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

output "etcd_lb_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.etcd_lb_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

