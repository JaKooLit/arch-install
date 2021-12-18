
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch.localdomain Arch" >> /etc/hosts
echo root:password | chpasswd

pacman -S grub  efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools  avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils alsa-utils easyeffects pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call  bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font linux-headers linux-zen linux-zen-headers


# extra utils

# pacman -S grub-btrfs base-devel bluez bluez-utils cups virt-manager qemu qemu-arch-extra edk2-ovmf

# pacman -S xf86-video-amdgpu 
# pacman -S nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=UEFI-Arch
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can uncomment this command out if you install tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -mG wheel jay
echo jay:password | chpasswd
usermod -aG libvirt jay

echo "jay ALL=(ALL) ALL" >> /etc/sudoers.d/jay


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

