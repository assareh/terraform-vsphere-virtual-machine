terraform {
  required_version = ">= 0.13"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 1.24.1"
    }
  }
}

provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "PacketDatacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "MainCluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "10.100.0.2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-16-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.environment}-${var.app_name}-vm"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  annotation = "Managed with Terraform"
  num_cpus   = var.num_cpus
  memory     = var.memory
  guest_id   = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
}

output "id" {
  value = vsphere_virtual_machine.vm.id
}

output "ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "name" {
  value = vsphere_virtual_machine.vm.name
}

output "ssh_addr" {
  value = <<SSH

    Connect to your virtual machine via SSH:
    $ ssh hashicorp@${vsphere_virtual_machine.vm.default_ip_address}
SSH
}