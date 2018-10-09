#!/bin/bash

echo "Copying files"

# Install slock with setuid on
sudo rm -rf /usr/local/bin/slock
sudo cp $(pwd)/utils/slock /usr/local/bin/
sudo chmod u+s /usr/local/bin/slock

# Install other utils
sudo rm -rf /usr/local/bin/i3class
sudo ln -s $(pwd)/utils/i3class.sh /usr/local/bin/i3class

sudo rm -rf /usr/local/bin/screen
sudo ln -s $(pwd)/utils/select-screen.sh /usr/local/bin/screen

sudo rm -rf /usr/local/bin/start_conky
sudo ln -s $(pwd)/utils/start_conky /usr/local/bin/start_conky

# Install i3 config and i3status
rm -rf ~/.i3
ln -s $(pwd)/i3 ~/.i3

rm -rf ~/.config/i3status
ln -s $(pwd)/i3status ~/.config/i3status

# Setup desktop background information
rm -rf ~/.config/conky
ln -s $(pwd)/conky ~/.config/conky

# Install ranger file manager
rm -rf ~/.config/ranger
ln -s $(pwd)/ranger ~/.config/ranger

rm -rf ~/.vimrc
ln -s $(pwd)/vim/vimrc ~/.vimrc

rm -rf ~/.Xresources
ln -s $(pwd)/xresources/Xresources ~/.Xresources

sudo pacman -S yay

