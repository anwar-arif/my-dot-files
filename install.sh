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
        sudo apt install $1 -y
    elif [ -x "$(command -v brew)" ]; then 
        brew install $1 -y
    elif [ -x "$(command -v apt-get)" ]; then
        sudo apt-get install $1 -y
    else 
        echo "I don't know your package manager"
    fi
}

install() {
    printf "installing ${GREEN}$1$NORMAL...\n"
    if ! [ -x "$(command -v $1)" ]; then
        prompt_install $1
    else
        printf "${GREEN}$1 is already installed $NORMAL\n"
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

install_snap_pkg() {
    local packages=("notion-snap" "code" "intellij-idea-ultimate --classic")
    for pkg in ${packages[@]}; do
        printf "installing ${GREEN}$pkg$NORMAL\n"
        sudo apt install $pkg
    done
}

install_cask_pkg() {
    local packages=("notion" "visual-studio-code" "intellij-idea" "datagrip")
    for pkg in ${packages[@]}; do
        printf "installing ${GREEN}$pkg$NORMAL\n"
        brew install --cask $pkg
    done
}

os_specific_pkg_install() {
    if [[ $OSTYPE == 'darwin'* ]]; then    
        install_cask_pkg
    else
        install_snap_pkg
    fi
}

main() {
    update
    local packages=("git" "git-gui" "zsh" "vim" "tmux")
    for pkg in ${packages[@]}; do
        install $pkg
    done

    os_specific_pkg_install
}

main $@
