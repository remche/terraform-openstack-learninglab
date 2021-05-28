# terraform-openstack-learninglab
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/remche/learninglab/openstack)

Build your learning lab on OpenStack

This module will spawn instances, create users and optionnaly set up a OCFS2 drive.

## :warning: Shared drive details

### Requirements
* A ceph volume type supporting [multiattach](https://docs.openstack.org/cinder/latest/admin/blockstorage-volume-multiattach.html)
* An OS image featuring OCFS2 services and kernel modules

### Usage
To avoid any data loss, the Cinder volume lifecyle is set to [prevent_destroy](https://www.terraform.io/docs/language/meta-arguments/lifecycle.html#prevent_destroy). It means that you won't be able to apply a plan that results in a volume destruction. To tear down the infrastructure, remove the volume from state first :

```bash
terraform state rm openstack_blockstorage_volume_v3.ocfs2[0]
terraform destroy
```

Orphaned volume can be later manually destroyed or reused in future infrastructure via `volume_id` variable.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_blockstorage_volume_v3.ocfs2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3) | resource |
| [openstack_compute_floatingip_associate_v2.associate_floating_ip](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_floatingip_associate_v2) | resource |
| [openstack_compute_instance_v2.instance](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_compute_volume_attach_v2.ocfs2_attach](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_volume_attach_v2) | resource |
| [openstack_networking_floatingip_v2.floating_ip](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_v2) | resource |
| [openstack_networking_network_v2.tp_net](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2) | resource |
| [openstack_networking_router_interface_v2.router_interface](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2) | resource |
| [openstack_networking_router_v2.router](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_v2) | resource |
| [openstack_networking_subnet_v2.tp_subnet](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_subnet_v2) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [openstack_networking_network_v2.dmz_net](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_network_v2) | data source |
| [template_cloudinit_config.config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | DNS domain | `string` | n/a | yes |
| <a name="input_dns_nameservers"></a> [dns\_nameservers](#input\_dns\_nameservers) | DNS nameservers | `list(string)` | n/a | yes |
| <a name="input_flavor"></a> [flavor](#input\_flavor) | Instance template | `string` | n/a | yes |
| <a name="input_floating_ip_network"></a> [floating\_ip\_network](#input\_floating\_ip\_network) | Public network to use | `string` | n/a | yes |
| <a name="input_hostname_prefix"></a> [hostname\_prefix](#input\_hostname\_prefix) | Prefix for instances | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Instance image | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instance to spawn | `number` | n/a | yes |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Instance keypair | `string` | n/a | yes |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | User passwords length | `number` | `16` | no |
| <a name="input_same_password"></a> [same\_password](#input\_same\_password) | Use same password for all users | `bool` | `false` | no |
| <a name="input_shared_volume"></a> [shared\_volume](#input\_shared\_volume) | Use a OCFS shared volume | `bool` | `false` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | Neutron subnet CIDR | `string` | `"192.168.1.0/24"` | no |
| <a name="input_user_count"></a> [user\_count](#input\_user\_count) | Number of user to create | `number` | n/a | yes |
| <a name="input_user_prefix"></a> [user\_prefix](#input\_user\_prefix) | Prefix for users | `string` | n/a | yes |
| <a name="input_volume_device"></a> [volume\_device](#input\_volume\_device) | OCFS shared volume device path | `string` | `"/dev/vdb"` | no |
| <a name="input_volume_id"></a> [volume\_id](#input\_volume\_id) | ID of an existing volume. Will create one if it does not exist | `string` | `""` | no |
| <a name="input_volume_mount_point"></a> [volume\_mount\_point](#input\_volume\_mount\_point) | OCFS shared volume mount point | `string` | `"/mnt"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | OCFS shared volume size | `number` | `3` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Cinder volume type (must support multiattach) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instances"></a> [instances](#output\_instances) | n/a |
| <a name="output_users"></a> [users](#output\_users) | n/a |
<!-- END_TF_DOCS -->
