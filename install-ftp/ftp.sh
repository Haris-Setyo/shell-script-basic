#!/bin/sh


sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

apt-get update
apt-get upgrade -y
apt-get install vsftpd -y

systemctl start vsftpd
systemctl enable vsftpd

sudo mkdir -p /srv/files/ftp
sudo usermod -d /srv/files/ftp ftp

sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.default

ufw allow 20/tcp
ufw allow 21/tcp

# write_enable=YES 
sed -i '/write_enable=YES/ s/^#*//' /etc/vsftpd.conf
# chroot_local_user=YES
sed -i '/chroot_local_user=YES/ s/^#*//' /etc/vsftpd.conf
#chroot_list_enable=YES
sed -i '/chroot_list_enable=YES/ s/^#*//' /etc/vsftpd.conf
# chroot_list_file=/etc/vsftpd.chroot_list
sed -i '/chroot_list_file=/ s/^#*//' /etc/vsftpd.conf

sudo touch /etc/vsftpd.chroot_list

systemctl restart vsftpd
systemctl status vsftpd

echo "Please edit /etc/vsftpd.chroot_list and add user can use ftp"
