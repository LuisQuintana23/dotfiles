#!/bin/bash


#vim config

#install vim-plug
sh -c 'curl -flo "${xdg_data_home:-$home/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#install plugins in vim from terminal
nvim -c 'pluginstall'

#coc (auto complete) languages servers

#coc needs node
#install node
sudo pacman -s nodejs npm
sudo npm i -g npm n
sudo n lts

#languages servers
nvim -c 'cocinstall coc-sh coc-pyright coc-java coc-tsserver coc-html coc-clangd coc-phpls'


