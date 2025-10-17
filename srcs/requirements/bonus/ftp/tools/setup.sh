#!/bin/sh

cat /etc/shadow | grep -w $FTP_USER

if [ $? -ne 0 ];then
	useradd -d /home/$FTP_USER -s /bin/bash $FTP_USER && echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

if [ ! -e /home/$FTP_USER/ftp ];then
	mkdir /home/$FTP_USER/ftp
fi

chown nobody:nogroup /home/$FTP_USER/ftp

chmod a-w /home/$FTP_USER/ftp

if [ ! -e /home/$FTP_USER/ftp/files ];then
	mkdir /home/$FTP_USER/ftp/files
fi

mkdir -p /var/run/vsftpd/empty

sed -i "s/#write_enable=YES/write_enable=YES/1" /etc/vsftpd.conf
sed -i "s/#chroot_local_user=YES/chroot_local_user=YES/1" /etc/vsftpd.conf

echo "local_enable=YES
pasv_enable=YES
local_root=/home/$FTP_USER/ftp
pasv_min_port=50000
pasv_max_port=50100
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

echo $FTP_USER | tee -a /etc/vsftpd.userlist

chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

exec "$@"
