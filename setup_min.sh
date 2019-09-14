#! /bin/bash

# minimal installation
sudo apt update
sudo apt install vim zsh curl git -y

#------------------------------------------------
#                zsh setup                       
#------------------------------------------------

# install oh-my-zsh and change the default shell
echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/exec zsh -l/d')"

# install zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i "s/\(plugins=(.*\))/\1 zsh-syntax-highlighting)/" ~/.zshrc

# some other settings for zsh
echo "autoload -Uz compinit" >> ~/.zshrc
echo "compinit" >> ~/.zshrc

#------------------------------------------------
#                vim setup                       
#------------------------------------------------

# install my vimrc
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/vimrc >> ~/.vimrc
# install surround.vim
git clone https://tpope.io/vim/surround.git ~/.vim/pack/tpope/start/surround
# add help tags for surround
(cd ~/.vim/pack/tpope/start && vim -u NONE -c "helptags surround/doc" -c q)
# install repeat.vim
git clone https://tpope.io/vim/repeat.git ~/.vim/pack/tpope/start/repeat
# status line for minimal version
echo "set statusline=%t%m%r%h%w%=%y[%{&ff}:%{&fenc!=''?&fenc:&enc}]%3p%%%3l:%3c" >> ~/.vimrc

exec zsh -l
