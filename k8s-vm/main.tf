resource "vsphere_virtual_machine" "controlplane_vm" {
  count = var.controlplane_vm_count
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

  name             = "${var.controlplane_vm.name}-${format("%02d", count.index+1)}"
  num_cpus         = "${var.controlplane_vm.num_cpus}"
  memory           = "${var.controlplane_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.controlplane_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.controlplane_vm.hostname}-${format("%02d", count.index+1)}"
        domain    = var.controlplane_vm.domain
        time_zone = var.controlplane_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.controlplane_vm.ipv4_prefix}.${count.index + var.controlplane_vm.ipv4_start}"
        ipv4_netmask = var.controlplane_vm.ipv4_netmask
      }
      ipv4_gateway = var.controlplane_vm.ipv4_gateway
      dns_server_list = var.controlplane_vm.dns_server_list
      
    }
  }
}

resource "vsphere_virtual_machine" "worker_vm" {
  count = var.worker_vm_count
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

  name             = "${var.worker_vm.name}-${format("%02d", count.index+1)}"
  num_cpus         = "${var.worker_vm.num_cpus}"
  memory           = "${var.worker_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.worker_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.worker_vm.hostname}-${format("%02d", count.index+1)}"
        domain    = var.worker_vm.domain
        time_zone = var.worker_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.worker_vm.ipv4_prefix}.${count.index + var.worker_vm.ipv4_start}"
        ipv4_netmask = var.worker_vm.ipv4_netmask
      }
      ipv4_gateway = var.worker_vm.ipv4_gateway
      dns_server_list = var.worker_vm.dns_server_list
      
    }
  }
}

resource "vsphere_virtual_machine" "api_lb_vm" {
  count = var.api_lb_vm_count
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

  name             = "${var.api_lb_vm.name}-${format("%02d", count.index+1)}"
  num_cpus         = "${var.api_lb_vm.num_cpus}"
  memory           = "${var.api_lb_vm.memory}"
  
  network_interface {
    network_id   = "${data.vsphere_network.vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.vm_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = var.api_lb_vm.disk_size
    thin_provisioned = "${data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned}"
    datastore_id     = "${data.vsphere_datastore.vm_datastore.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm_template.id}"

    customize {      
      linux_options {
        host_name = "${var.api_lb_vm.hostname}-${format("%02d", count.index+1)}"
        domain    = var.api_lb_vm.domain
        time_zone = var.api_lb_vm.time_zone
      }
      network_interface {
        ipv4_address = "${var.api_lb_vm.ipv4_prefix}.${count.index + var.api_lb_vm.ipv4_start}"
        ipv4_netmask = var.api_lb_vm.ipv4_netmask
      }
      ipv4_gateway = var.api_lb_vm.ipv4_gateway
      dns_server_list = var.api_lb_vm.dns_server_list
    }
  }
}

output "controlplane_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.controlplane_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

output "worker_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.worker_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

output "api_lb_vm_info" {
  value = {
    for entry in vsphere_virtual_machine.api_lb_vm : 
    entry.name => {
      ip = entry.default_ip_address
      memory = entry.memory
      num_cpus = entry.num_cpus
    }
  }
}

