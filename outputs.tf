output "id" {
  value = vsphere_virtual_machine.vm.id
}

output "name" {
  value = vsphere_virtual_machine.vm.name
}

output "ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "http_addr" {
  value = <<HTTP
Connect to your virtual machine via HTTP:
http://${vsphere_virtual_machine.vm.default_ip_address}
HTTP
}

output "ssh_addr" {
  value = <<SSH
Connect to your virtual machine via SSH:
ssh ubuntu@${vsphere_virtual_machine.vm.default_ip_address}
SSH
}

output "router_ip" {
  value = vsphere_virtual_machine.router.guest_ip_addresses
}

output "router_ssh_addr" {
  value = <<SSH
Connect to your router via SSH:
ssh ubuntu@${vsphere_virtual_machine.router.guest_ip_addresses}
SSH
}
