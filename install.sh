#!/bin/bash

packages="xclip neovim zsh python-pip universal-ctags rofi brightnessctl yad xdotool lolcat variety fzf"

function configure(){ # is equivalente to config alias
	# $@ allows to add more parameters and use it like alias
	/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@ 
}


function create(){
	sudo pacman -Sy
	sudo pacman -S git zsh --noconfirm

	#create alias
	echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> $HOME/.zshrc 
	echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> $HOME/.bashrc 

	#bare repository

	git init --bare $HOME/.dotfiles

}

function backup_files(){
	mkdir $HOME/.dotfiles_bak

	echo "Backing up files..."
	#the next line uses the filenames in conflict and move inside the backup folder
	configure checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I {} mv $HOME/{} $HOME/.dotfiles_bak/{}
	
	echo -e "\n-----Backed up files-----\n"

}


function install(){

	#INSTALL fundamentals
        sudo pacman -Syy
	sudo pacman -S archlinux-keyring --noconfirm
	sudo pacman -S "$packages" --noconfirm #universal tags is to identify classes, functions on vim
        sudo pacman -S --needed base-devel git --noconfirm
    

	#verify if yay is installed
	pacman -Q | grep "yay"	
	
	if [[ "$?" -ne 0 ]];then
	    git clone https://aur.archlinux.org/yay.git $HOME/yay
	    (cd $HOME/yay && makepkg -si PKGBUILD && rm -rf $HOME/yay)
	fi



	#create alias
	echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> $HOME/.zshrc 
	echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> $HOME/.bashrc 
	echo ".dotfiles/" >> $HOME/.gitignore

	git clone --bare git@github.com:LuisQuintana23/dotfiles.git $HOME/.dotfiles
	configure checkout

	if [[ "$?" -ne 0 ]];then
		backup_files
	fi

	configure checkout -f #force overwrite dotfiles


	#VIM CONFIG

	#install vim-plug
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	#install plugins in vim from terminal
	nvim -c 'PlugInstall'

	#coc (auto complete) languages servers

	#coc needs node
	#INSTALL NODE
	sudo pacman -S nodejs npm
	sudo npm i -g npm n
	sudo n lts

	#languages servers
	nvim -c 'CocInstall coc-sh coc-pyright coc-java coc-tsserver coc-html coc-clangd coc-phpls'


	#FONTS
	# clone
	git clone https://github.com/powerline/fonts.git --depth=1 $HOME/fonts
	# install
	/bin/bash $HOME/fonts/install.sh
	# clean-up a bit
	rm -rf $HOME/fonts

	#nerd fonts for alacritty
	yay -S nerd-fonts-jetbrains-mono appimagelauncher --noconfirm


	#fonts custom
	cp -r $HOME/.custom_fonts/* $HOME/.local/share/fonts/

	#picom fork install
	yay -S picom-jonaburg-git --noconfirm


	#ranger image viewer
	sudo pip3 install ueberzug neovim


	#change shell
	chsh -s $(which zsh)

	# set lockscreen blur

	echo -e "To set a lockscreen wallpaper, run:\n\tbetterlockscreen -u <path wallpaper> --blur 1.0"



	echo "====FINISHED===="
}


mkdir $HOME/.dotfiles


if [[ "$#" -ne 1 ]];then
	echo -e "\nPlease use one of the next parameters\n\t--create\n\t--install\n"
	exit 1
fi


#	[[[[[[	MAIN MENU ]]]]]]

if [[ "$1" == "--create" ]];then

	create

elif [[ "$1" == "--install" ]];then
	install

else
	echo -e "\nPlease use one of the next parameters\n\t--create\n\t--install\n"
	exit 1
fi

#allows not to show files without tracking
configure config --local status.showUntrackedFiles no 
