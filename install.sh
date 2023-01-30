#!/bin/bash

function main(){
	#verify if yay is installed
	pacman -Q | grep "yay"	
	
	if [[ "$?" -ne 0 ]];then
	    git clone https://aur.archlinux.org/yay.git $HOME/yay
	    (cd $HOME/yay && makepkg -si PKGBUILD && rm -rf $HOME/yay)
	fi

	#vim config

	#install vim-plug
	sh -c 'curl -flo "${xdg_data_home:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	#install plugins in vim from terminal
	nvim -c 'PlugInstall'

	#coc (auto complete) languages servers

	#coc needs node
	#install node
	sudo pacman -S nodejs npm
	sudo npm i -g npm n
	sudo n lts

	#languages servers
	nvim -c 'CocInstall coc-sh coc-pyright coc-java coc-tsserver coc-html coc-clangd coc-phpls'

	#powerline fonts for alacritty
	yay -S powerline-fonts-git --noconfirm

	#change shell
	chsh -s $(which zsh)

	echo -e "To set a lockscreen wallpaper, run:\n\tbetterlockscreen -u <path wallpaper> --blur 1.0"

	echo "====FINISHED===="
}

main "$@"
