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

rm -rf ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

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
rm -rf ~/.zshrc
ln -s $(pwd)/zsh/zshrc ~/.zshrc

# Switch to zsh
chsh -s /usr/bin/zsh

echo "Configuring vim"

rm -rf ~/.vim_runtime
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

pushd ~/.vim/bundle
if [ ! -d "goyo.vim" ]; then
    git clone https://github.com/junegunn/goyo.vim.git
else
    cd goyo.vim
    git pull
    cd ..
fi
if [ ! -d "nerdtree" ]; then
    git clone https://github.com/scrooloose/nerdtree.git
    #pushd nerdtree
    #git checkout tags/5.0.0
    #popd
else
    cd nerdtree
    git pull
    cd ..
fi
if [ ! -d "nord-vim" ]; then
    git clone https://github.com/arcticicestudio/nord-vim.git
    #pushd nord-vim
    #git checkout tags/v0.11.0
    #popd
else
    cd nord-vim
    git pull
    cd ..
fi
if [ ! -d "toml" ]; then
    git clone https://github.com/cespare/vim-toml.git
else
    cd toml
    git pull
    cd ..
fi
if [ ! -d "vim-airline" ]; then
    git clone https://github.com/bling/vim-airline
else
    cd vim-airline
    git pull
    cd ..
fi
if [ ! -d "vim-airline-themes" ]; then
    git clone https://github.com/vim-airline/vim-airline-themes
else
    cd vim-airline-themes
    git pull
    cd ..
fi
if [ ! -d "vim-gitgutter" ]; then
    git clone https://github.com/airblade/vim-gitgutter.git
else
    cd vim-gitgutter
    git pull
    cd ..
fi
if [ ! -d "vim-solidity" ]; then
    git clone https://github.com/tomlion/vim-solidity.git
else
    cd vim-solidity
    git pull
    cd ..
fi
if [ ! -d "youcompleteme" ]; then
    git clone https://github.com/Valloric/youcompleteme.git
    pushd youcompleteme
    git submodule update --init --recursive
    python3 install.py --rust-completer
    popd
    # Install the Rust source code
    rustup component add rust-src
else
    cd youcompleteme
    git pull
    cd ..
fi
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

