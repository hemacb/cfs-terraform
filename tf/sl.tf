provider "softlayer" {
}
resource "softlayer_virtual_guest" "myveryownserver1" {
    name = "hostname"
    domain = "cfscos2.com"
    image = "osname"
    #image = "REDHAT_7_64"
    #block_device_template_group_gid = "imagename"
    region = "che01"
    hourly_billing = true
    local_disk = false
    cpu = cpucount
    disks = [rootdisk]
    #disks = [25]
    ram = ramsize
    public_network_speed = 10
    post_install_script_uri = "piscript"
    user_data = "userdata"
}
output "myserver_ip" {
  value = "${softlayer_virtual_guest.myveryownserver1.ipv4_address}"
}
