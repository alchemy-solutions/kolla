#!/bin/bash

# TODO(SamYaple): Tweak libvirt.conf rather than change permissions.
# Fix permissions for libvirt
# Do not remove unless CentOS has been validated
if [[ -c /dev/kvm ]]; then
    chmod 660 /dev/kvm
    chown root:kvm /dev/kvm
fi

# Mount xenfs for libxl to work
if [[ $(lsmod | grep xenfs) ]]; then
    mount -t xenfs xenfs /proc/xen
fi

if [[ ! -d "/var/log/kolla/nova" ]]; then
    mkdir -p /var/log/kolla/nova
fi
if [[ $(stat -c %a /var/log/kolla/nova) != "755" ]]; then
    chmod 755 /var/log/kolla/nova
fi
