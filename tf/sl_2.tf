provider "softlayer" {
}
resource "softlayer_virtual_guest" "webhostname" {
    name = "webhostname"
    domain = "cfscos2.com"
    image = "webosname"
    #image = "REDHAT_7_64"
    #block_device_template_group_gid = "imagename"
    region = "che01"
    hourly_billing = true
    local_disk = false
    cpu = webcpucount
    disks = [webrootdisk]
    #disks = [25]
    ram = webramsize
    public_network_speed = 10
    post_install_script_uri = "webpiscript"
    user_data = "webuserdata"
}
output "myserver_ip" {
  value = "${softlayer_virtual_guest.webhostname.ipv4_address}"
}
resource "softlayer_virtual_guest" "dbhostname" {
    name = "dbhostname"
    domain = "cfscos2.com"
    image = "dbosname"
    #image = "REDHAT_7_64"
    #block_device_template_group_gid = "imagename"
    region = "che01"
    hourly_billing = true
    local_disk = false
    cpu = dbcpucount
    disks = [dbrootdisk]
    #disks = [25]
    ram = dbramsize
    public_network_speed = 10
    post_install_script_uri = "dbpiscript"
    user_data = "dbuserdata"
}
output "myserver_ip" {
  value = "${softlayer_virtual_guest.dbhostname.ipv4_address}"
}

