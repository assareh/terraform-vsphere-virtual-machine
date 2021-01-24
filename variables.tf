#############################
##   vSphere - Variables   ##
#############################

variable "vsphere_server" {
  type        = string
  description = "vSphere Server name"
  default     = "192.168.10.7"
}

variable "vsphere_dc" {
  type        = string
  description = "vSphere Datacenter name"
  default     = "Datacenter"
}

variable "vsphere_host" {
  type        = string
  description = "vSphere Host name"
  default     = "192.168.10.11"
}

variable "vsphere_datastore" {
  type        = string
  description = "vSphere datastore name"
  default     = "datastore1"
}

variable "vsphere_network" {
  type        = string
  description = "vSphere network name"
  default     = "VM Network"
}

variable "vsphere_template" {
  type        = string
  description = "vSphere VM template name"
  default     = "assareh-hashidemos"
}

#############################
## Application - Variables ##
#############################

# application name
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# description
variable "description" {
  type        = string
  description = "Provide a description of the resource"
}

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# owner
variable "owner" {
  type        = string
  description = "Specify the owner of the resource"
}

#############################
##     VM - Variables      ##
#############################

# num cpus
variable "num_cpus" {
  type        = number
  description = "Specify the number of cores to assign"
  default     = 1
}

# memory
variable "memory" {
  type        = number
  description = "Specify the amount of memory in MB to assign"
  default     = 512
}

# disk size
variable "disk_size" {
  type        = number
  description = "Specify the amount of storage in GB to assign"
  default     = 16
}

# variable "disks" {
#   type    = "map"
# }

# variable "network_interfaces" {
#   type    = "map"
# }

#############################
##    Tags - Variables     ##
#############################

# time to live on resources
variable "ttl" {
  type        = number
  description = "Value of ttl tag on cloud resources"
  default     = 3
}

# tags
locals {
  common_tags = <<EOF
    owner     = assareh
    se-region = AMER - West E2 - R2
    purpose   = Demo Terraform and Vault
    ttl       = ${var.ttl} hours
    terraform = true
EOF
}