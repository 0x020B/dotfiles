vmlinuz-linux-zen cryptdevice=/dev/sda2:fs cryptkey=/dev/sda1:vfat:diskkey \
		root=/dev/mapper/fs rootflags=compress=lzo,subvol=@ rw \
		usr=/dev/mapper/fs usrflags=compress=lzosubvol=@usr rw \
		initrd=initramfs-linux-zen.img
