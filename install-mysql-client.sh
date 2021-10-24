#!/bin/bash

installclient() {
    cat <<EOF >/etc/yum.repos.d/mysql-community.repo
[mysql57-community]
    name=MySQL 5.7 Community Server
    baseurl=https://mirrors.cloud.tencent.com/mysql/yum/mysql-5.7-community-el7-x86_64/
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
EOF
yum install mysql-community-client.x86_64 -y

}

case $1 in
    install)
        installclient
        ;;
esac