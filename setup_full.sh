#! /bin/bash

sudo apt update
sudo apt install vim zsh curl git neovim -y

#------------------------------------------------
#                zsh setup                       
#------------------------------------------------

# install oh-my-zsh and change the default shell
echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/exec zsh -l/d')"

# install powerlevel9k theme for zsh
git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
sed -i "s/ZSH_THEME=.*/ZSH_THEME=\"powerlevel9k\/powerlevel9k\"/" ~/.zshrc
echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)" >> ~/.zshrc
echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator dir_writable)" >> ~/.zshrc

# install zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i "s/\(plugins=(.*\))/\1 zsh-syntax-highlighting)/" ~/.zshrc

# some other settings for zsh
echo "autoload -Uz compinit" >> ~/.zshrc
echo "compinit" >> ~/.zshrc

# use neovim instead of vim in the full version

#------------------------------------------------
#                vim setup                       
#------------------------------------------------

# install my vimrc
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/vimrc >> ~/.vimrc

# install solarized theme for vim
mkdir -p ~/.vim/colors
curl -fsSL https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim >> ~/.vim/colors/solarized.vim
echo "colorscheme solarized" >> ~/.vimrc
echo "set background=dark" >> ~/.vimrc
# install surround.vim
git clone https://tpope.io/vim/surround.git ~/.vim/pack/tpope/start/surround
# add help tags for surround
(cd ~/.vim/pack/tpope/start && vim -u NONE -c "helptags surround/doc" -c q)
# install repeat.vim
git clone https://tpope.io/vim/repeat.git ~/.vim/pack/tpope/start/repeat
# install vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
# add help tags for vim-airline
(cd ~/.vim/pack/dist/start && vim -u NONE -c "helptags vim-airline/doc" -c q)
# install solarized theme for vim-airline
mkdir -p ~/.vim/autoload/airline/themes
curl -fsSL https://raw.githubusercontent.com/vim-airline/vim-airline-themes/master/autoload/airline/themes/solarized.vim >> ~/.vim/autoload/airline/themes/solarized.vim
echo "let g:airline_theme='solarized'" >> ~/.vimrc
echo "let g:airline_powerline_fonts=1" >> ~/.vimrc
echo "let g:airline_extensions=[]" >> ~/.vimrc

#------------------------------------------------
#                neovim setup                       
#------------------------------------------------

mkdir -p ~/.config/nvim
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/init.vim >> ~/.config/nvim/init.vim
cp -r ~/.vim/* ~/.config/nvim/
echo "alias vim='nvim'"

#------------------------------------------------
#                other non-gui setup                       
#------------------------------------------------

# custom keyboard layout EN_DE
bash $(curl -fsSL https://raw.githubusercontent.com/HE7086/EN-DE_keyboardLayout/master/linux/install_remote.sh)

# font
sudo apt install fonts-firacode -y

# development kit
sudo apt install default-jdk haskell-platform python3-dev nodejs -y

# command line meme tools
sudo apt install sl fortune cowsay lolcat -y

# command line tools
sudo apt install htop neofetch python-pip python3-pip python3-setuptools -y
sudo pip3 install thefuck
echo 'eval $(thefuck --alias)' >> ~/.zshrc

# install kitty
sh $(curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh)
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/kitty.conf >> ~/.config/kitty/kitty.conf
echo "kitty + complete setup zsh" >> ~/.zshrc

# power manager for thinkpads
if test "$(dmidecode -s system-version | grep -i thinkpad)" != ""
then
    sudo add-apt-repository ppa:linrunner/tlp
    sudo apt install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms -y
    if test -e /sys/class/power_supply/BAT1
    then
        echo 'alias charge="sudo tlp fullcharge bat0 && sudo tlp fullcharge bat1"' >> ~/.zshrc
        sed -i "s/#\(.\+BAT0.\+\)/\1/" /etc/default/tlp
        sed -i "s/#\(.\+BAT1.\+\)/\1/" /etc/default/tlp
    else
        echo 'alias charge="sudo tlp fullcharge bat0"' >> ~/.zshrc
        sed -i "s/#\(.\+BAT0.\+\)/\1/" /etc/default/tlp
    fi
fi

#------------------------------------------------
#               other gui setup
#------------------------------------------------
sudo apt install gnome-tweaks synaptic alacarte vim-gui-common -y
echo 'set guifont=Fira\ Code\ Retina' >> ~/.vimrc
#------------------------------------------------
#                   finish
#------------------------------------------------
# run at last since it would stop the previous shell
echo "Installation Finished!"
exec zsh -l
