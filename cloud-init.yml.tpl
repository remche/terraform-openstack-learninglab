ssh_pwauth: True
users:
  - default
%{ for user in users ~}
  - name: ${user[0]}
    plain_text_passwd: ${user[1]}
    lock_passwd: false
    shell: /bin/bash
%{ endfor ~}

%{ if disk != "" ~}
write_files:
  - path: /etc/ocfs2/cluster.conf
    content: |
%{ for instance in instances ~}
      node:
        ip_port = 7777
        ip_address = ${instance[2]}
        number = ${instance[0]}
        name = ${instance[1]}
        cluster = ocfs2
%{ endfor ~}
      cluster:
        node_count = ${instance_count}
        name = ocfs2
runcmd:
  - [ sh, -c, '[ "$(hostname)" = "${instances[0][1]}" ] && (sudo o2info  ${disk} --mkfs || sudo  mkfs.ocfs2 ${disk})']
  - sudo mkdir -p ${mount_point}
mounts:
  - [ ${disk}, ${mount_point}, "ocfs2", "_netdev", "0", "0"]
power_state:
  mode: reboot
%{ endif ~}