terraform {
  required_providers {
    libvirt = {
      source = "hashicorp/libvirt"
    }
    hosts = {
      source = "hashicorp/hosts"
    }
    iptables = {
      source = "hashicorp/iptables"
    }
  }
}
 

provider "libvirt" {
  ## Configuration options
  uri = "qemu:///system"
  #alias = "server2"
  #uri   = "qemu+ssh://root@192.168.100.10/system"
}

provider "hosts" {
    file = "/etc/hosts"
    zone = "myzone"
}

provider "iptables" {
  firewall_ip         = "192.168.1.12"
  port                = 8443
  allowed_cidr_blocks = ["0.0.0.0/0"]
#  https               = true
#  insecure            = true
#  vault_enable        = true
}

