#!/bin/bash

# Only update permissions if permissions need to be updated
if [[ $(stat -c %U:%G /var/lib/neutron/kolla) != "neutron:neutron" ]]; then
    sudo chown neutron: /var/lib/neutron/kolla
fi

if [[ ! -d "/var/log/kolla/neutron" ]]; then
    mkdir -p /var/log/kolla/neutron
fi
if [[ $(stat -c %a /var/log/kolla/neutron) != "755" ]]; then
    chmod 755 /var/log/kolla/neutron
fi
