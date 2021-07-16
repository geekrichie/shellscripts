#!/bin/bash
install_docker(){
    curl -fsSL get.docker.com -o get-docker.sh
    sudo sh get-docker.sh --mirror Aliyun
    sudo systemctl enable docker
    sudo systemctl start docker
    docker run --rm hello-world
}

uninstall_docker(){
    sudo yum remove docker-ce docker-ce-cli containerd.io
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}
#这里需要将当前用户添加到docker用户组里面就可以运行docker run  
#虚拟机可能需要重启才能生效
docker_user_add() {
    sudo groupadd docker
    sudo usermod -aG docker $USER
    docker run --rm hello-world
}

case $1 in
    install)
        install_docker
        ;;
    uninstall)
        uninstall_docker
        ;;
    adduser)
        docker_user_add
        ;;
esac