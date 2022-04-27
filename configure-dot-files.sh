#!/bin/sh

isInstalled() {
    local pkg=$1
    local result="false"
    if [ -x "$(command -v $pkg)" ]; then
        result="true"
        else 
            result="false"
    fi
    echo $result
}

configure_zsh() {
    local pkg=$1
    local installed=$(isInstalled $pkg)

    if [ "$installed" == "false" ] ; then
        printf "please install $pkg before configuring\n"
        exit 1
    else
        
    fi

}

main() {
    configure_zsh
}   

main $@
