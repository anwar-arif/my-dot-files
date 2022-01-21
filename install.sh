#!/bin/sh

YELLOW="\e[0;40;93m"
RED="\e[0;40;91m"
NORMAL="\e[0;40;0m"
GREEN="\e[0;40;92m"
ORANGE="\e[0;40;33m"
PURPLE="\e[0;40;96m"
BLINK="\e[0;40;5m"

prompt_install() {
    if [ -x "$(command -v apt)" ]; then
        sudo apt install $1
    elif [ -x "$(command -v brew)" ]; then 
        brew install $1
    elif [ -x "$(command -v apt-get)" ]; then
        sudo apt-get install $1
    else 
        echo "I don't know your package manager"
    fi
}

install() {
    echo "installing $1..."
    if ! [ -x "$(command -v $1)" ]; then
        prompt_install $1
    else
        echo "${GREEN}git is already installed $NORMAL"
    fi
}

update() {
    if [ -x "$(command -v apt)" ]; then
        sudo apt update
    elif [ -x "$(command -v brew)" ]; then
        brew update
    elif [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
    else 
        echo "I don't know your package manager"
    fi
}

main() {
    update
    install git
}

main $@
