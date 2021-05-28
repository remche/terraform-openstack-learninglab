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
  - [ sh, -c, 'while [ ! -b ${disk} ]; do echo "Waiting for OCFS2 volume" && sleep 10; done']
  - [ sh, -c, '[ "$(hostname)" = "${instances[0][1]}" ] && (sudo o2info  ${disk} --mkfs || sudo  mkfs.ocfs2 ${disk})' ]
  - [ sh, -c, '[ "$(hostname)" = "${instances[0][1]}" ] && (sudo fsck.ocfs2 /dev/vdb && sudo tunefs.ocfs2 -N ${instance_count} ${disk})' ]
  - sudo mkdir -p ${mount_point}
  - [ sh, -c, 'sudo echo "${disk}	${mount_point} ocfs2 _netdev 0 0" >> /etc/fstab']
  - [ sh, -c, 'while ! (sudo o2info ${disk} --volinfo|grep "Node Slots: ${instance_count}"); do echo "Waiting OCFS2 volume format/resize" && sleep 10; done; sleep 10 && sudo mount -a']
%{ endif ~}
