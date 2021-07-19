#!/bin/sh
reset-last-author() {
    #change last commit user.name and user.email
    git commit --amend --reset-author
}

config-user-info() {
    git config user.name  $1
    git config user.email $2
}

