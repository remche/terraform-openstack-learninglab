resource "openstack_blockstorage_volume_v3" "ocfs2" {
  count       = var.shared_volume ? 1 : 0
  name        = "${var.hostname_prefix}-ocfs2"
  size        = var.volume_size
  multiattach = true
  volume_type = var.volume_type
  lifecycle {
    prevent_destroy  = true
  }
}

resource "openstack_compute_volume_attach_v2" "ocfs2_attach" {
  count       = var.shared_volume ? var.instance_count : 0
  instance_id = openstack_compute_instance_v2.instance[count.index].id
  volume_id   = openstack_blockstorage_volume_v3.ocfs2[0].id
  multiattach = true
}
