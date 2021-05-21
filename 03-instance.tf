data "template_cloudinit_config" "config" {
  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile(("${path.module}/cloud-init.yml.tmpl"),
      { users = local.users,
        instances = local.instances
        instance_count = var.instance_count
        disk = var.volume_device
        mount_point = var.volume_mount_point
    })
  }
}

resource "openstack_compute_instance_v2" "instance" {
  count       = var.instance_count
  name        = local.instances[count.index][1]
  image_name  = var.image_name
  flavor_name = var.flavor
  key_pair    = var.key_pair
  user_data   = data.template_cloudinit_config.config.rendered
  network {
    uuid = openstack_networking_network_v2.tp_net.id
    fixed_ip_v4 = local.instances[count.index][2]
  }

  security_groups = ["default"]
}

resource "openstack_networking_floatingip_v2" "floating_ip" {
  count      = var.instance_count
  pool       = var.floating_ip_network
  dns_name   = openstack_compute_instance_v2.instance[count.index].name
  dns_domain = var.dns_domain
}

resource "openstack_compute_floatingip_associate_v2" "associate_floating_ip" {
  count       = var.instance_count
  floating_ip = openstack_networking_floatingip_v2.floating_ip[count.index].address
  instance_id = openstack_compute_instance_v2.instance[count.index].id
}
