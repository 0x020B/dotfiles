#!/bin/sh
sfdisk --delete /dev/sda
parted /dev/sda mklabel gpt mkpart ESP fat32 1M 513M
parted /dev/sda mkpart primary btrfs 513M 100%
mkfs.btrfs -n 32k /dev/sda2
mount -vo compress=lzo /dev/sda2 /mnt
btrfs -v subvolume create /mnt/@
btrfs -v subvolume create /mnt/@etc
btrfs -v subvolume create /mnt/@home
btrfs -v subvolume create /mnt/@swap
umount /mnt
mount -vo noatime,nodiratime,compress=lzo,subvol=@ /dev/sda2 /mnt
mkdir -v /mnt{boot,etc,home}
mount -v /dev/sda1 /mnt/boot
mount -vo noatime,nodiratime,compress=lzo,subvol=@etc /dev/sda2 /mnt/etc
mount -vo noatime,nodiratime,compress=lzo,subvol=@home /dev/sda2 /mnt/home
truncate -s 0 /mnt/swap
chattr +C /mnt/swap
fallocate -l 8G /mnt/swap
chmod 0600 /mnt/swap
mkswap /mnt/swap
swapon /mnt/swap
#semanage fcontext -a -t swapfile_t /mnt/swap
#restorecon /mnt/swap
pacstrap -K /mnt	base-devel-selinux	amd-ucode	\		
			linux-zen		linux-firmware	\
			btrfs-progs		duperemove	\
			dhcpcd			wpa_supplicant	\
			zsh			oh-my-zsh-git	\
			vim			neovim		\
			man-db			man-pages	\
			sway			xorg-xwayland	\
			yakuake			firejail	\
			bat			rsync		\
			colordiff	
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --adjfile /mnt/etc/adjtime
cp -v etc/* /mnt/etc
arch-chroot /mnt mkinitcpio -P
arch-chroot /mnt useradd -m -G wheel -s /usr/bin/zsh n0tr00t
arch-chroot /mnt passwd n0tr00t
efibootmgr --create --disk /dev/sda --part 1 \
	--label 'Linux' \
	--loader /vmlinuz-linux-zen \
	--unicode "root=$(findmnt -no UUID /mnt)"' rw initrd=\amd-ucode.img initrd=\initramfs-linux-zen.img'
umount -Rv /mnt
