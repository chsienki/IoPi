#!/bootstrapper/busybox sh
busy="/bootstrapper/busybox"

# Right now, root is the boot partition

# lets mount the main pi partition
$busy mkdir "/mnt" "/dev"
$busy mount -t devtmpfs none "/dev"
$busy mount -o rw -t ext4 "/dev/sda2" "/mnt"

# at this point, we can do whatever we want to! 
$busy mkdir -p "/mnt/opt/iopi/" "/mnt/opt/iopi/bin" "/mnt/opt/iopi/var"
$busy cp "/service/startup.sh" "/mnt/opt/iopi/bin" 
$busy cp "/service/lib.sh" "/mnt/opt/iopi/bin"
$busy cp "/service/iopi.service" "/mnt/etc/systemd/system"
$busy ln -s "/mnt/etc/systemd/system/iopi.service" "/mnt/etc/systemd/system/multi-user.target.wants"
#$busy sh

# unmount the root partition
$busy sync
$busy umount "/mnt"
$busy umount "/dev"
$busy rm -r /mnt /dev

# restore the cmdline
$busy mv /cmdline.txt.orig /cmdline.txt -f
$busy sync

#reboot
$busy sleep 5
$busy reboot -f
