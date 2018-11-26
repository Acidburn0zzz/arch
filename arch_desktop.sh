#!/bin/bash

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -c Germany -p https -l10 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme file-roller firefox gedit git gvfs htop network-manager-applet noto-fonts pavucontrol pulseaudio pycharm-community-edition slock ttf-dejavu thunar-archive-plugin ufw xfce4 xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-whiskermenu-plugin xorg-server # nvidia
# TODO test blanking with and without nvidia
# TODO test acpid on laptop
sudo pacman -Rs xfwm4-themes
sudo systemctl stop dhcpcd
sudo systemctl enable --now NetworkManager.service systemd-timesyncd.service ufw.service

# AUR
mkdir AUR && cd AUR
git clone https://aur.archlinux.org/flat-remix-git.git
cd flat-remix-git && makepkg -cis && cd ..
git clone https://aur.archlinux.org/dropbox.git
cd dropbox && makepkg -cis
# TODO write custom script

# Miniconda
cd && curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
source .bashrc && conda update --all

# Configuration
cd && git clone https://github.com/astier/dotfiles.git
cd dotfiles && bash install.sh

reboot

# Maintenance
# TODO silent boot
# TODO health-check-script
# kernel, systemd, journal, xorg
# systemctl --all --failed
# journalctl -p3 -xb / -xe
# sudo pacman -Rns$(pacman -Qtdg)
