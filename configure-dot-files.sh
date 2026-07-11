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
    printf "${PURPLE}Cloning dotfiles repo${NORMAL}\n"
    if ! test -d $DOT_FOLDER; then
        git clone https://github.com/anwar-arif/my-dot-files.git $DOT_FOLDER
        printf "${GREEN}Cloned dotfiles repo${NORMAL}\n"
    else
        printf "${YELLOW}Repo already exists. Doing a git pull...${NORMAL}\n"
        git -C $DOT_FOLDER pull
    fi

	# set up dot files to `source` in home directory
	if [[ $OSTYPE == 'darwin'* ]]; then
        echo "source ~/my-dot-files/macos/.zshrc" >> ~/.zshrc
		echo "source ~/my-dot-files/macos/.vimrc" >> ~/.vimrc
		echo "source ~/my-dot-files/macos/.tmux.conf" >> ~/.tmux.conf
    else
        echo "source ~/my-dot-files/linux/.zshrc" >> ~/.zshrc
		echo "source ~/my-dot-files/linux/.vimrc" >> ~/.vimrc
		echo "source ~/my-dot-files/linux/.tmux.conf" >> ~/.tmux.conf
    fi

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
	source ~/.zshrc
	printf "${GREEN}zsh plugin setup complete${NORMAL}\n"
}

setup_tmux_plugin() {
    printf "${PURPLE}Installing tmux plugins${NORMAL}\n"
    # Checking Tmux Plugin Manager
	if ! test -d "$HOME/.tmux/plugins/tpm"; then
		printf "${YELLOW}Cloning \"Tmux Plugin Manager\"...${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
		printf "${GREEN}done...${NORMAL}\n"
	fi
    # Checking tmux-sensible
	if ! test -d "$HOME/.tmux/plugins/tmux-sensible"; then
		printf "${YELLOW}Cloning \"tmux-sensible\"...${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tmux-sensible $HOME/.tmux/plugins/tmux-sensible
		printf "${GREEN}done...${NORMAL}\n"
	fi
    # Checking tmux-yank
	if ! test -d "$HOME/.tmux/plugins/tmux-yank"; then
		printf "${YELLOW}Cloning \"tmux-yank\"${NORMAL}\n"
		git clone https://github.com/tmux-plugins/tmux-yank $HOME/.tmux/plugins/tmux-yank
		printf "${GREEN}done...${NORMAL}\n"
	fi
    printf "${GREEN}Tmux plugin setup complete${NORMAL}\n"

	printf "${GREEN}Sourcing tmux...${NORMAL}\n"
	tmux source-file ~/.tmux.conf
	printf "${GREEN}Sourcing tmux complete${NORMAL}\n"
}

setup_vim_plugin() {
	printf "${PURPLE}Installing vim plugins${NORMAL}\n"
	if ! test -d "$HOME/.vim/bundle/Vundle.vim"; then
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi
	vim +PluginInstall +qall
	# No need to run `source ~/.vimrc` from terminal, vim will automatically load the configuration
	# If you're inside vim, to reload the config do this - Press Esc, then type ':source ~/.vimrc'
	printf "${GREEN}Vim plugin setup complete${NORMAL}\n"
}

setup_fish() {
	printf "${PURPLE}Installing fish plugins${NORMAL}\n"
	git clone https://github.com/anwar-arif/.config.git ~
	git clone https://github.com/oh-my-fish/oh-my-fish ~
	printf "${GREEN}Fish setup complete${NORMAL}\n"
}

main() {
  	clone_dotfile_repo
	setup_vim_plugin
	setup_zsh_plugin
	setup_tmux_plugin
	setup_fish
}

main $@
