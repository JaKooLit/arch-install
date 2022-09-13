#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c KR,HK,TW,SG,JP -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

#edit the packages as required
sudo pacman -S xorg sddm plasma-desktop konsole packagekit-qt5 kwallet-pam noto-fonts ark ttf-hack adobe-source-han-sans-otc-fonts

sudo pacman -S adobe-source-han-serif-otc-fonts noto-fonts-cjk powerdevil plasma-nm bluedevil firefox spectacle gwenview vlc kate dolphin

sudo pacman -S dolphin-plugins powerline-fonts discover sddm-kcm print-manager khotkeys kscreen kgamma5 kinfocenter ksystemlog filelight plasma-pa

#wayland
# sudo pacman -S xdg-desktop-portal-kde plasma-wayland-session kvantum

#additional if required

sudo systemctl enable sddm

echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#reboot
