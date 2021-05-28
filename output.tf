output "users" {
  sensitive = true
  value = { for user in local.users :
    user[0] => user[1]
  }
  description = "List of users/passwords"
}

output "instances" {
  sensitive = true
  value = { for index, instance in local.instances :
    "${instance[1]}.${trimsuffix(var.dns_domain, ".")}" => openstack_compute_floatingip_associate_v2.associate_floating_ip[index].floating_ip
  }
  description = "List of instances"
}
