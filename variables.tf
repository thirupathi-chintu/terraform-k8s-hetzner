variable "ssh_public_key" {
  description = "SSH public key to be copied on machines"
  default = "~/.ssh/sirpi.pub"
}

variable "ssh_private_key" {
  description = "SSH private key to be used to log into machines"
  default = "~/.ssh/sirpi"
}

variable "node_image" {
  default = "ubuntu-18.04"
}

variable "master_type" {
  default = "cx21"
}

variable "worker_type" {
  default = "cx11"
}

variable "hcloud_token" {
}
variable "workers" {
  default = 1
}
