#!/bin/bash
#删除yum安装的php
removephp() {
    yum list installed | grep php | awk '{print $1 }' | xargs yum remove -y
}

installnginx() {
    downloadurl=https://nginx.org/download/nginx-1.20.1.tar.gz
    basename=$(basename ${downloadurl})
    wget ${downloadurl} -O ${basename}
    #tar -xzvf downloadurl -C /usr/local/nginx

}

checknginxpackage() {
    ls . | grep 'nginx-[\.[[:digit:]]]*?.tar.gz'
}


installnginx