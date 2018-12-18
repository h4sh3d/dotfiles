#!/bin/bash

echo "Start installation..."

echo "Copying files"

# Install slock with setuid on
sudo rm -rf /usr/local/bin/slock
sudo cp $(pwd)/utils/slock /usr/local/bin/
sudo chmod u+s /usr/local/bin/slock
# Install i3exit script
sudo rm -rf /usr/bin/i3exit
sudo cp $(pwd)/utils/i3exit.sh /usr/bin/i3exit

# Install other utils
sudo rm -rf /usr/local/bin/i3class
sudo ln -s $(pwd)/utils/i3class.sh /usr/local/bin/i3class

sudo rm -rf /usr/local/bin/screen
sudo ln -s $(pwd)/utils/select-screen.sh /usr/local/bin/screen

sudo rm -rf /usr/local/bin/start_conky
sudo ln -s $(pwd)/utils/start_conky /usr/local/bin/start_conky

# Configure i3 and i3status
rm -rf ~/.i3
ln -s $(pwd)/i3 ~/.i3

rm -rf ~/.config/i3status
ln -s $(pwd)/i3status ~/.config/i3status

# Setup desktop background information
rm -rf ~/.config/conky
ln -s $(pwd)/conky ~/.config/conky

# Configure ranger file manager
rm -rf ~/.config/ranger
ln -s $(pwd)/ranger ~/.config/ranger

# Xressources
rm -rf ~/.Xresources
cp $(pwd)/xresources/Xresources ~/.Xresources

echo "Configuring TERM"

# Install xterm
yay -S xterm

echo "Configuring SHELL"

# Install zsh
yay -S zsh

pushd
rm -rf ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
popd

# Install pure prompt
rm -rf ~/.config/pure
pushd ~/.config
git clone https://github.com/sindresorhus/pure.git pure
popd
sudo rm -rf /usr/local/share/zsh/site-functions/prompt_pure_setup /usr/local/share/zsh/site-functions/async
sudo ln -s ~/.config/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
sudo ln -s ~/.config/pure/async.zsh /usr/local/share/zsh/site-functions/async

rm -rf ~/.zshrc.bak
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
cp $(pwd)/zsh/zshrc ~/.zshrc

# Switch to zsh
chsh -s /usr/bin/zsh

echo "Configuring vim"

pushd
rm -rf ~/.vim_runtime
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
popd

rm -rf ~/.vimrc
ln -s $(pwd)/vim/vimrc ~/.vimrc

echo "Configuring Git"

rm -rf ~/.gitconfig
ln -s $(pwd)/git/gitconfig ~/.gitconfig

echo "Configuring greeter"

# Install greeter
yay -S lightdm-mini-greeter

[ -f /etc/lightdm/lightdm-mini-greeter.conf ] && sudo mv /etc/lightdm/lightdm-mini-greeter.conf /etc/lightdm/lightdm-mini-greeter.conf.bak
sudo cp $(pwd)/greeter/lightdm-mini-greeter.conf /etc/lightdm/lightdm-mini-greeter.conf
sudo sed -i s/lightdm-slick-greeter/lightdm-mini-greeter/ /etc/lightdm/lightdm.conf

