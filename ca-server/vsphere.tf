provider "vsphere" {
  vsphere_server       = "${var.vsphere.server}"
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "${var.vsphere.datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere.compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "vm_template" {
  name          = "${var.vsphere_template.name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "vm_template_datastore" {
  name          = "${var.vsphere_template.datastore}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "vm_template_network" {
  name          = "${var.vsphere_template.network}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "vm_datastore" {
  name          = "${var.vsphere_vm.datastore}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}


data "vsphere_network" "vm_network" {
  name          = "${var.vsphere_vm.network}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}