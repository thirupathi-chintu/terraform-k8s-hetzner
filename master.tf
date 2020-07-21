# Add public key resource
resource "hcloud_ssh_key" "cluster_admin" {
	name       = "cluster_admin"
	public_key = "${file(var.ssh_public_key)}"
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
	token = "${var.hcloud_token}"
}

# Configure Floating_ip
resource "hcloud_floating_ip" "master" {
  type = "ipv4"
  server_id = "${hcloud_server.master.id}"
  name = "kubernetes-master"
}

# Bootstrap and initialize master
resource "hcloud_server" "master" {
	name = "kubernetes-master"
	image = "${var.node_image}"
	server_type = "${var.master_type}"
	ssh_keys = ["${hcloud_ssh_key.cluster_admin.id}"]

	connection {
		host = "${hcloud_server.master.ipv4_address}"
		private_key = "${file(var.ssh_private_key)}"
	}

	provisioner "local-exec" {
	command = "mkdir -p config-jenkins"
	}

	provisioner "file" {
		source      = "${path.module}/config-jenkins"
		destination = "config-jenkins/"
	}

	provisioner "file" {
		source      = "${path.module}/hack/bootstrap.sh"
		destination = "/root/bootstrap.sh"
	}

	provisioner "remote-exec" {
		inline = ["/bin/bash /root/bootstrap.sh"]
	}

	provisioner "file" {
		source      = "${path.module}/hack/master.sh"
		destination = "/root/master.sh"
	}
	
	provisioner "remote-exec" {
		inline = ["/bin/bash /root/master.sh"]
	}

	provisioner "local-exec" {
	command = "bash ${path.module}/hack/copy_local.sh"
		environment = {
			SSH_PRIVATE_KEY 	= "${var.ssh_private_key}"
			SSH_CONN   			= "root@${hcloud_server.master.ipv4_address}"
			COPY_TO_LOCAL    	= "creds/"
		}
	}
}
