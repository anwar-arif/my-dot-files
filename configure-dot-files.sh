#!/bin/sh

install_zsh() {
    echo "installing zsh..."
    if ! [ -x "$(command -v zsh)" ]; then
        sudo apt install zsh
    else 
        echo "zsh is installed already"
    fi
}

install_vim() {
    echo "installing vim..."
    if ! [ -x "$(command -v vim)" ]; then
        sudo apt install vim
    else 
        echo "vim is installed already"
    fi
}

install_tmux() {
    echo "installing tmux..."
    if ! [ -x "$(command -v tmux)" ]; then
        sudo apt install tmux
    else
        echo "tmux is installed already"
    fi
}

main() {
    install_zsh
    install_vim
    install_tmux
}   

main $@
