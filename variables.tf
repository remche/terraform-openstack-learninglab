variable "user_count" {
  type = number
}

variable "user_prefix" {
  type = string
}

variable "image_name" {
  type = string
}

variable "flavor" {
  type = string
}

variable "key_pair" {
  type = string

}

variable "instance_count" {
  type = number
}

variable "hostname_prefix" {
  type = string
}

variable "floating_ip_network" {
  type = string
}

variable "dns_domain" {
  type = string
}

variable "dns_nameservers" {
  type = list(string)
}

variable "subnet_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "shared_volume" {
  type    = bool
  default = false
}

variable "volume_size" {
  type    = number
  default = 3
}

variable "volume_type" {
  type = string
}

variable "volume_device" {
  type    = string
  default = "/dev/vdb"
}

variable "volume_mount_point" {
  type    = string
  default = "/mnt"
}
