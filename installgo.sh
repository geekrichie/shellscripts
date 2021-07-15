#!/bin/bash
installgo() {
    targeturl=https://golang.google.cn/dl/go1.15.5.linux-amd64.tar.gz
    basename=$(basename ${targeturl})
    wget $targeturl -O ${basename}
    tar -C /usr/local -xzf ${basename}
    echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
    source /etc/profile
}

setgoproxy()  {
     go env -w GO111MODULE=on
     go env -w GOPROXY=https://goproxy.cn,direct
}

case $1 in
    install)
        installgo
        ;;
    proxy)
        setgoproxy
        ;;
esac

       