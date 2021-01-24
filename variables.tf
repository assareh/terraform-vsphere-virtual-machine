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