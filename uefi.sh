#!/bin/bash

reflector -c KR -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch.localdomain Arch" >> /etc/hosts

#remember to change the password here default is 1
echo root:1 | chpasswd

pacman -S grub base-devel efibootmgr networkmanager wpa_supplicant network-manager-applet dialog mtools dosfstools avahi xdg-user-dirs xdg-utils gvfs
pacman -S gvfs-smb gvfs-mtp nfs-utils inetutils dnsutils alsa-utils bash-completion rsync reflector acpi 
pacman -S acpi_call bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft firewalld sof-firmware nss-mdns acpid ntfs-3g 
pacman -S linux-headers

#zen kernel, btrfs additional zram
pacman -S linux-headers linux-zen linux-zen-headers grub-btrfs zram-generator

#pipewire
pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-x11-bell realtime-privileges wireplumber 

# easyeffects 
pacman -S easyeffects

#bluetooth
pacman -S bluez bluez-utils

#if blueman desired
#pacman -S blueman blueman-applet blueman-manager blueman

#pacman -S virt-manager qemu qemu-arch-extra edk2-ovmf

# if installing on qemu /kvm

#pacman -S qemu-guest-agent spice-vdagent xf86-video-qxl

#VIDEO CARDS!

# pacman -S xf86-video-intel
# pacman -S xf86-video-amdgpu 
# pacman -S nvidia nvidia-utils nvidia-settings

#note! remember to identify your proper esp partition. This setup is separate efi and boot partition

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=UEFI-Arch
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
#systemctl enable qemu-guest-agent #uncomment if installed qemu-guest-agent


#change user name default is ja
useradd -mG wheel ja

#change the password. default is one
echo ja:1 | chpasswd
#usermod -aG libvirt ja


#only if desired
#echo "ja ALL=(ALL) ALL" >> /etc/sudoers.d/ja

#if adding sudoers is not desired run VISUDO before exit to make defaul user as sudoer / elevator user


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

