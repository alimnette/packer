
source "vsphere-iso" "Ubuntu" {
  CPUs                 = 4
  RAM                  = 2048
  RAM_reserve_all      = true
  boot_command         = [
                            "<enter><enter><f6><esc><wait>",
                            "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
                            "<enter>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "5s"
  cluster              = "${var.cluster}"
  convert_to_template  = "false"
  datastore            = "${var.datastore}"
  disk_controller_type = ["pvscsi"]
  folder               = "${var.folder}"
  guest_os_type        = "ubuntu64Guest"
  host                 = "${var.host}"
  http_directory       = "http"
  # output_directory     = "output/live-server"
  insecure_connection  = "true"
  iso_paths            = ["[ISO2] Linux/ubuntu-20.04.2-live-server-amd64.iso"]

  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }

  
  ip_settle_timeout = "5m"
  ssh_password = "${var.ssh_password}"
  ssh_timeout  = "60m"
  ssh_handshake_attempts = "20"
  ssh_username = "${var.ssh_username}"

  storage {
    disk_size             = 32768
    disk_thin_provisioned = true
  }

  username       = "${var.username}"
  password       = "${var.password}"
  vcenter_server = "${var.vcenter_server}"
  vm_name        = "${var.name-tpl}"
}

build {
  sources = ["source.vsphere-iso.Ubuntu"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S -E bash '{{ .Path }}'"
    scripts         = ["script.sh"]
  }

}
