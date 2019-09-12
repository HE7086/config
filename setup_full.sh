#! /bin/bash
#if $TERM == "Linux" then
#    exit 0
#fi

# minimal installation
apt update
apt install vim zsh curl git -y

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

#------------------------------------------------
#                vim setup                       
#------------------------------------------------

# install my vimrc
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/vimrc >> ~/.vimrc

# install solarized theme for vim
curl -fsSL https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim >> ~/.vim/colors/solarized.vim
echo "colorscheme solarized" >> ~/.vimrc
echo "set background=dark" >> ~/.vimrc
# install surround.vim
git clone https://tpope.io/vim/surround.git ~/.vim/pack/tpope/start
# add help tags for surround
(cd ~/.vim/pack/tpope/start && vim -u NONE -c "helptags surround/doc" -c q)
# install repeat.vim
git clone https://tpope.io/vim/repeat.git ~/.vim/pack/tpope/start
# install vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
# add help tags for vim-airline
(cd ~/.vim/pack/dist/start && vim -u NONE -c "helptags vim-airline/doc" -c q)
# install solarized theme for vim-airline
curl -fsSL https://raw.githubusercontent.com/vim-airline/vim-airline-themes/master/autoload/airline/themes/solarized.vim >> ~/.vim/autoload/airline/themes/solarized.vim
echo "g:airline_theme='solarized'" >> ~/.vimrc
echo "g:airline_powerline_fonts=1" >> ~/.vimrc

#------------------------------------------------
#                other useful setup                       
#------------------------------------------------

# custom keyboard layout EN_DE
bash $(curl -fsSL https://raw.githubusercontent.com/HE7086/EN-DE_keyboardLayout/master/linux/install_remote.sh)

# font
apt install fonts-firacode -y

# development kit
apt install default-jdk haskell-platform python3-dev nodejs -y

# command line meme tools
apt install sl fortune cowsay lolcat -y

# command line tools
apt install htop neofetch python-pip python3-pip -y
pip3 install thefuck
echo 'eval $(thefuck --alias)' >> ~/.zshrc

# install kitty
sh $(curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh)
curl -fsSL https://raw.githubusercontent.com/HE7086/config/master/config/kitty.conf >> ~/.config/kitty/kitty.conf
echo "kitty + complete setup zsh" >> ~/.zshrc

# power manager for thinkpads
if test "$(dmidecode -s system-version | grep -i thinkpad)" != ""
then
    add-apt-repository ppa:linrunner/tlp
    apt install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms -y
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

# run at last since it would stop the previous shell
exec zsh -l
