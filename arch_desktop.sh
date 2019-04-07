#!/usr/bin/env bash

# Autologin
systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Mirrorlist
systemctl start dhcpcd.service
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber compton feh firefox git light neovim noto-fonts-cjk pulsemixer scrot texlive-bibtexextra texlive-core ttf-dejavu ufw wpa_supplicant xdg-utils xorg-server xorg-xinit xsel zathura-pdf-poppler # nvidia
sudo pacman -Rns dhcpcd nano netctl vi

# Misc
systemctl enable systemd-networkd.service systemd-resolved.service systemd-timesyncd.service ufw.service
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo ufw enable
sudo localectl set-x11-keymap de pc105 nodeadkeys caps:swapescape

# wpa_supplicant
sudo nvim /etc/wpa_supplicant/wpa_supplicant-wlp1s0.conf
# ctrl_interface=/run/wpa_supplicant
# ctrl_interface_group=wheel
# update_config=1
chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlp1s0.conf
systemctl enable wpa_supplicant@wlp1s0.service

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -rf yay
yay -S dropbox flat-remix-git i3lock-blur xbanish

# Dotfiles
mkdir ~/Projects/
cd ~/Projects/
git clone https://github.com/astier/dotfiles
sh dotfiles/install.sh
. dotfiles/dotfiles/.bashrc

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
conda update --all
# conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Suckless
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean
sudo ln /usr/local/bin/st /usr/bin/xterm

# Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
conda create -n nvi psutil
conda activate nvi
pip install neovim-remote # black
# conda activate isy
# conda install isort jedi pylint rope
# pip install python-language-server

# Projects
cd ~/Projects/
git clone https://github.com/astier/arch
git clone https://github.com/astier/scripts
sh scripts/install.sh
