cheat sheet for arch installation

prepare your drive

lsblk
gdisk
mkfs.vfat /dev/boot-drive
mkfs.btrfs /dev/root drive
mount /dev/root /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @var
cd
umount /mnt
mount -o noatime,compress=zstd:5,space_cache,discard=async,subvol=@ /dev/root /mnt
mkdir /mnt/{boot,home,var}
mount -o noatime,compress=zstd:5.space_cache,discard=async,subvol=@home /dev/root /mnt/home
mount -o noatime,compress=zstd:5.space_cache,discard=async,subvol=@var /dev/root /mnt/var
mount /dev/boot(drive) /mnt/boot

pacstrap /mnt base linux linux-firmware git vim amd-ucode/intel-ucode btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

install uefi.sh - from the file

chmod +x uefi.sh

sudo ./archinstall/uefi.sh

before reboot after uefi


vim /etc/mkinitcpio.conf
modules add (amdgpu nvidia) - as applicable
mkinitcpi -p linux

