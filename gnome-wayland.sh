#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c KR,HK,TW,SG,JP -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

#minimal-gnome
sudo pacman -S gnome-shell nautilus gnome-terminal guake gnome-tweak-tool gnome-control-center xdg-user-dirs gdm eog gnome-menus firemanager-actions
sudo pacman -S firefox gnome-browser-connector gnome-screenshot gnome-shell-extensions gnome-tweaks arc-gtk-theme arc-icon-theme vlc 

# fonts edit as required
sudo pacman -S ttf-droid gnu-free-fonts tf-liberation ttf-linux-libertine noto-fonts ttf-roboto ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji

#sudo pacman -S gnome-extra gnome 
sudo pacman -S xdg-desktop-portal-gtk xdg-desktop-portal-gnome xdg-desktop-portal

# sudo pacman -S --noconfirm xorg

sudo systemctl enable gdm

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#sudo reboot
