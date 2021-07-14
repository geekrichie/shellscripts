#!/bin/bash
#删除yum安装的php
removephp() {
    yum list installed | grep php | awk '{print $1 }' | xargs yum remove -y
}

installnginx() {
    workdir=$(pwd)
    downloadurl=https://nginx.org/download/nginx-1.16.1.tar.gz
    basename=$(basename ${downloadurl})
    checknginxpackage
    if [ $? -eq 1 ]; then
        wget ${downloadurl} -O ${basename}
    fi
    if [ ! -d 'nginx-1.16.1' ]; then
          tar -xzvf ${basename} 
    fi
    yum install -y gcc gcc-c++
    #gzip 依赖zlib库
    yum install -y zlib zlib-devel
    #XSLT 依赖libxml2
    yum install -y libxslt libxslt-devel
    #image 依赖gd库
    yum install -y gd gd-devel
    #GeoIP 依赖GeoIP库
    yum install -y GeoIP GeoIP-devel

    yum install -y unzip 

    if [ ! -d ${workdir}/nginx-1.16.1/modules/echo-nginx-module-0.62 ]; then
        installechomodule
    fi

    if [ ! -d /usr/local/src/pcre-8.36 ]; then
        installpcre
    fi

    if [ ! -d /usr/local/src/openssl-1.0.1p ]; then
        installopenssl
    fi
    
    cd $workdir/nginx-1.16.1 
    ./configure --prefix=/usr/local/nginx --error-log-path=/data/nginx/logs/error.log --pid-path=/var/run/nginx.pid --lock-path=/var/lock/nginx.lock --http-log-path=/data/nginx/logs/access.log --http-client-body-temp-path=/data/nginx/client_body_temp --http-proxy-temp-path=/data/nginx/proxy_temp --http-fastcgi-temp-path=/data/nginx/fastcgi_temp --http-uwsgi-temp-path=/data/nginx/uwsgi_temp --http-scgi-temp-path=/data/nginx/scgi_temp --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-openssl=/usr/local/src/openssl-1.0.1p --with-debug --with-pcre=/usr/local/src/pcre-8.36 --with-pcre-jit --add-module=modules/echo-nginx-module-0.62
    make 
    make install
    /usr/local/nginx/sbin/nginx -v
}

installechomodule() {
      cd nginx-1.16.1 
      mkdir modules 
      cd modules
      wget https://github.com/openresty/echo-nginx-module/archive/refs/tags/v0.62.zip 
      unzip v0.62.zip
    
}
installpcre() {
    cd /usr/local/src
    wget https://ftp.pcre.org/pub/pcre/pcre-8.36.tar.gz
    tar -zxvf pcre-8.36.tar.gz
    cd pcre-8.36
    ./configure
    make
    make install
}

installopenssl() {
    cd /usr/local/src
    wget http://www.openssl.org/source/openssl-1.0.1p.tar.gz
    tar -zxvf openssl-1.0.1p.tar.gz
}

checknginxpackage() {
   ls . | grep 'nginx-[.0-9]*\.tar\.gz' 
}

case $1 in
    nginx)
        installnginx
        ;;
esac