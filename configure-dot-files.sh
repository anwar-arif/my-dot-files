#!/bin/sh

YELLOW="\e[0;40;93m"
RED="\e[0;40;91m"
NORMAL="\e[0;40;0m"
GREEN="\e[0;40;92m"
ORANGE="\e[0;40;33m"
PURPLE="\e[0;40;96m"
BLINK="\e[0;40;5m"
DOT_FOLDER="$HOME/my-dot-files"

clone_dotfile_repo() {
    printf "${PURPLE}Clonning dotfiles repo${NORMAL}\n"
    if ! test -d $DOT_FOLDER; then
        git clone https://github.com/anwar-arif/my-dot-files.git $DOT_FOLDER
    else
        git -C $DOT_FOLDER pull
    fi
    printf "${GREEN}Clonned dotfiles repo${NORMAL}\n"
}

setup_zsh_plugin() {
    printf "${PURPLE}Installing zsh plugins${NORMAL}\n"
	if ! test -d "$HOME/.oh-my-zsh"; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
	if ! test -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"; then
		git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
	else
		git -C "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" pull
	fi
	if ! test -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	else
		git -C "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" pull
	fi
	if ! test -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions; then
		git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	else
		git -C ""$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"" pull
	fi
	printf "${GREEN}Zsh plugin setup complete${NORMAL}\n"
}

setup_tmux_plugin() {
    printf "${PURPLE}Installing tmux plugins${NORMAL}\n"
    # Checking Tmux Plugin Manager
	if ! test -d "$HOME/.tmux/plugins/tpm"; then
		printf "${YELLOW}WARNING: \"Tmux Plugin Manager\" not found${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	fi
    # Checking tmux-sensible
	if ! test -d "$HOME/.tmux/plugins/tmux-sensible"; then
		printf "${YELLOW}WARNING: \"tmux-sensible\" not found${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tmux-sensible $HOME/.tmux/plugins/tmux-sensible
	fi
    # Checking tmux-yank
	if ! test -d "$HOME/.tmux/plugins/tmux-yank"; then
		printf "${YELLOW}WARNING: \"tmux-yank\" not found${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tmux-yank $HOME/.tmux/plugins/tmux-yank
	fi
    printf "${GREEN}Tmux plugin setup complete${NORMAL}\n"
}

main() {
    clone_dotfile_repo
    setup_zsh_plugin
    setup_tmux_plugin
}   

main $@
