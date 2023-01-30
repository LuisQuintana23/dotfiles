#!/bin/bash

#list=("alacritty" "bspwm" "cmus" "neofetch" "nvim" "polybar" "ranger" "rofi" "sxhkd" "zathura")

list=("pcmanfm" "qtile" "Thunar")


for folder in "${list[@]}";do
    mkdir -p ./"$folder"/.config/"$folder"
    cp -r $HOME/.config/"$folder"/* ./"$folder"/.config/"$folder"/
done
