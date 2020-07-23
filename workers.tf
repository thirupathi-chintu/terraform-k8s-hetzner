# Configure Floating_ip
# resource "hcloud_floating_ip" "worker" {
#   count       = "${var.workers}"
#   name        = "worker-${count.index}"
#   type = "ipv4"
#   server_id = "${hcloud_server.worker[count.index].id}"
# }

resource "hcloud_server" "worker" {
  count       = "${var.workers}"
  name        = "worker-${count.index}"
  server_type = "${var.worker_type}"
  image       = "${var.node_image}"
  depends_on  = ["hcloud_server.master"]
  ssh_keys    = ["${hcloud_ssh_key.cluster_admin.id}"]

  connection {
    host = self.ipv4_address
    private_key = "${file(var.ssh_private_key)}"
  }

  provisioner "file" {
    source      = "${path.module}/hack/bootstrap.sh"
    destination = "/root/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = ["/bin/bash /root/bootstrap.sh"]
  }

  provisioner "file" {
    source      = "${path.module}/creds/cluster_join"
    destination = "/tmp/cluster_join"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }

  provisioner "file" {
    source      = "${path.module}/hack/node.sh"
    destination = "/root/node.sh"
  }

  provisioner "remote-exec" {
    inline = ["bash /root/node.sh"]
  }
}
