#!/bin/bash

if [[ "${KOLLA_BASE_DISTRO}" == "ubuntu" || \
        "${KOLLA_BASE_DISTRO}" == "debian" ]]; then
    # Loading Apache2 ENV variables
    source /etc/apache2/envvars
fi

# NOTE(pbourke): httpd will not clean up after itself in some cases which
# results in the container not being able to restart. Unconfirmed if this
# happens on Ubuntu. (bug #1489676)
if [[ "${KOLLA_BASE_DISTRO}" =~ fedora|centos|oraclelinux|rhel ]]; then
    rm -rf /var/run/httpd/* /run/httpd/* /tmp/httpd*
fi

# FIXME: Loading modules for version and wsgi
if [[ "${KOLLA_BASE_DISTRO}" =~ opensuse|sles ]]; then
    cat >>/etc/apache2/loadmodule.conf <<EOD
LoadModule version_module                 /usr/lib64/apache2-prefork/mod_version.so
LoadModule wsgi_module                    /usr/lib64/apache2/mod_wsgi.so
EOD
fi
