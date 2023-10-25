terraform {
  required_providers {
    libvirt = {
      source = "hashicorp/libvirt"
    }
    hosts = {
      source = "hashicorp/hosts"
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

