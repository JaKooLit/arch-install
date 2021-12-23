cheat sheet for arch installation (UEFI)

prepare your drive

lsblk

use cfdisk fdisk cgdisk or any to prepare disk

mkfs.vfat /dev/boot-drive

mkfs.btrfs /dev/root drive

mount /dev/root /mnt

cd /mnt

btrfs subvolume create @

btrfs subvolume create @home

cd

umount /mnt

mount -o noatime,compress=zstd:5,space_cache,discard=async,subvol=@ /dev/root /mnt

mkdir /mnt/{boot,home}
mount -o noatime,compress=zstd:5.space_cache,discard=async,subvol=@home /dev/root /mnt/home

mount /dev/boot(drive) /mnt/boot

pacstrap /mnt base linux linux-firmware git vim amd-ucode/intel-ucode btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

install uefi.sh - from the file edit with vim or any text editor downloaded in the pacstrap installation

chmod +x uefi.sh

sudo ./archin-stall/uefi.sh

before reboot after uefi


vim /etc/mkinitcpio.conf

modules add (btrfs amdgpu nvidia) - as applicable

mkinitcpio -P

