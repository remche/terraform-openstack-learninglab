variable "user_count" {
  type        = number
  description = "Number of user to create"
}

variable "user_prefix" {
  type        = string
  description = "Prefix for users"
}

variable "password_length" {
  type        = number
  description = "User passwords length"
  default     = 16
}

variable "image_name" {
  type        = string
  description = "Instance image"
}

variable "flavor" {
  type        = string
  description = "Instance template"
}

variable "key_pair" {
  type        = string
  description = "Instance keypair"
}

variable "instance_count" {
  type        = number
  description = "Number of instance to spawn"
}

variable "hostname_prefix" {
  type        = string
  description = "Prefix for instances"
}

variable "floating_ip_network" {
  type        = string
  description = "Public network to use"
}

variable "dns_domain" {
  type        = string
  description = "DNS domain"
}

variable "dns_nameservers" {
  type        = list(string)
  description = "DNS nameservers"
}

variable "subnet_cidr" {
  type        = string
  default     = "192.168.1.0/24"
  description = "Neutron subnet CIDR"
}

variable "shared_volume" {
  type        = bool
  default     = false
  description = "Use a OCFS shared volume"
}

variable "volume_id" {
  type        = string
  default     = ""
  description = "ID of an existing volume. Will create one if it does not exist"
}

variable "volume_size" {
  type        = number
  default     = 3
  description = "OCFS shared volume size"
}

variable "volume_type" {
  type        = string
  description = "Cinder volume type (must support multiattach)"
  default     = ""
}

variable "volume_device" {
  type        = string
  default     = "/dev/vdb"
  description = "OCFS shared volume device path"
}

variable "volume_mount_point" {
  type        = string
  default     = "/mnt"
  description = "OCFS shared volume mount point"
}
