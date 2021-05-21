resource "openstack_blockstorage_volume_v3" "ocfs2" {
  name        = "${var.hostname_prefix}-ocfs2"
  size        = 3
  multiattach = true
  volume_type = var.volume_type
}

resource "openstack_compute_volume_attach_v2" "ocfs2-attach" {
  count       = var.instance_count
  instance_id = openstack_compute_instance_v2.instance[count.index].id
  volume_id   = openstack_blockstorage_volume_v3.ocfs2.id
  multiattach = true
}
