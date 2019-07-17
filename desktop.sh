#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# PACKAGES
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --score 4 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme dash firefox light neovim pulsemixer slock tmux ttf-dejavu xcompmgr xorg-server xorg-xinit xsel
sudo pacman -Rns autoconf automake dhcpcd efibootmgr mdadm nano netctl reiserfsprogs s-nail vi xfsprogs diffutils gettext jfsutils lvm2 patch iproute2 iputils licenses logrotate pciutils psmisc which usbutils bison fakeroot flex m4 pkgconf man-pages sed
rm ~/.bash_logout

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
sudo pacman -Rns go
cd .. && rm -fr yay .cache/go-build
yay -S dropbox

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/arch
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh

# SUCKLESS
mkdir ~/projects/suckless && cd ~/projects/suckless || exit
git clone https://git.suckless.org/sites
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu/src && sudo make install clean
cd ../../dwm/src && sudo make install clean
cd ../../st/src && sudo make install clean

# CONFIGURATION
chsh -s /bin/dash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable fstrim.timer systemd-timesyncd.service

sudo reboot
