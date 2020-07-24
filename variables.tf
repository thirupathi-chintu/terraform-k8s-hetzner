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
  default = "cpx31"
}

variable "worker_type" {
  default = "cpx51"
}

variable "hcloud_token" {
  default = "MMUfKv7RkU8yZ7nw7B1UQe5179PpCjmWx2Y1I3gZ7Kv111aokTWxF1tTuAzak7wl"
}
variable "workers" {
  default = 1
}
