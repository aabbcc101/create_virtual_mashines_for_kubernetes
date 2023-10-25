
#####

# MASTER 1

#####
                                                  
# Defining VM Volume

resource "libvirt_volume" "kub_master_1-qcow2" {
  name = "kub_master_1.qcow2"
  pool = libvirt_pool.cluster.name  # List storage pools using virsh pool-list
  source = "./debian-12-nocloud-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "big-kub_master_1-qcow2" {
  name           = "big-kub_master_1-qcow2"
  base_volume_id = libvirt_volume.kub_master_1-qcow2.id
  pool           = "cluster"
  size           = 20737418240
}

# Define KVM domain to create

resource "libvirt_domain" "kub_master_1" {
  name   = "kub_master_1"
  memory = "2048"
  vcpu   = 2
  autostart = true

  network_interface {
    addresses      = ["192.168.10.2"]
    network_name = "kub_net"
    hostname       = "kub-master-1"
    mac            = "de:4d:ca:02:0a:8d"
  }

  disk {
    volume_id = "${libvirt_volume.big-kub_master_1-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

}

resource "hosts_record" "kub_master_1" {
    address = "192.168.10.2"
    names   = [ "kubmaster1", "kubmaster1.local" ]
    comment = "server kub_master_1"
    notes   = "a kubernetes master server"
}

