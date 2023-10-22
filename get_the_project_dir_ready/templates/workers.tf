
#####

# WORKER 1

#####
                                                  
# Defining VM Volume

resource "libvirt_volume" "kub_worker_1-qcow2" {
  name = "kub_worker_1.qcow2"
  pool = libvirt_pool.cluster.name  # List storage pools using virsh pool-list
  source = "./debian-12-nocloud-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "big-kub_worker_1-qcow2" {
  name           = "big-kub_worker_1-qcow2"
  base_volume_id = libvirt_volume.kub_worker_1-qcow2.id
  pool           = "cluster"
  size           = 20737418240
}

# Define KVM domain to create

resource "libvirt_domain" "kub_worker_1" {
  name   = "kub_worker_1"
  memory = "1048"
  vcpu   = 1
  autostart = true

  network_interface {
    addresses      = ["192.168.10.11"]
    network_name = "kub_net"
    hostname       = "kub-worker-1"
    mac            = "de:4d:ca:11:0a:8d"
  }

  disk {
    volume_id = "${libvirt_volume.big-kub_worker_1-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

}


#####

# WORKER 2

#####

# Defining VM Volume

resource "libvirt_volume" "kub_worker_2-qcow2" {
  name = "kub_worker_2.qcow2"
  pool = libvirt_pool.cluster.name  # List storage pools using virsh pool-list
  source = "./debian-12-nocloud-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "big-kub_worker_2-qcow2" {
  name           = "big-kub_worker_2-qcow2"
  base_volume_id = libvirt_volume.kub_worker_2-qcow2.id
  pool           = "cluster"
  size           = 20737418240
}

# Define KVM domain to create

resource "libvirt_domain" "kub_worker_2" {
  name   = "kub_worker_2"
  memory = "1048"
  vcpu   = 1
  autostart = true

  network_interface {
    addresses      = ["192.168.10.12"]
    network_name = "kub_net"
    hostname       = "kub-worker-2"
    mac            = "de:4d:ca:12:0a:8d"
  }

  disk {
    volume_id = "${libvirt_volume.big-kub_worker_2-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

}

