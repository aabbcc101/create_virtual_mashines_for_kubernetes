
#####

# Create extra NETWORK

#####

resource "libvirt_network" "kub_net" {
  name      = "kub_net"
  autostart = true
  addresses = ["192.168.10.0/24"]
  dhcp {
    enabled = true
  }
#  dns {
#    enabled = true
#  }
}


#####

# Create extra POOL

#####

# A pool for all cluster volumes
resource "libvirt_pool" "cluster" {
  name = "cluster"
  type = "dir"
  path = "/home/vlad/cluster_storage"
}

