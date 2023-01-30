#!/bin/bash

pacman -Qqt > ./packages.list
pacman -Qqtm > ./.yay.list
pacman -Qqtn > ./.pacman.list

# remove yay from yay list
sed -i '/^yay$/d' .yay.list
