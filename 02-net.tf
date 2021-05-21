data "openstack_networking_network_v2" "dmz_net" {
  name = var.floating_ip_network
}
resource "openstack_networking_network_v2" "tp_net" {
  name                  = "tp-net"
  admin_state_up        = "true"
  port_security_enabled = "true"
}

resource "openstack_networking_subnet_v2" "tp_subnet" {
  name            = "tp-subnet"
  network_id      = openstack_networking_network_v2.tp_net.id
  cidr            = var.subnet_cidr
  gateway_ip      = cidrhost(var.subnet_cidr, -2)
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

resource "openstack_networking_router_v2" "router" {
  name                = "tp-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.dmz_net.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.tp_subnet.id
}
