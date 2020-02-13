#!/bin/bash
# iREP-JVF local backup to NAS809 on Toronto network via FTP
#
# This script will backup everything that is essential
# to iREP and will upload it via FTP to NAS809/irepbackup

### System Setup ###
### backup directory for temp. file storage.
BACKUP=/home/irep/iREP-tmp-backup

### FTP ###
FTPD="/irepbackup"
FTPU="KEEPASS"
FTPP="KEEPASS"
FTPS="10.1.1.32"

### Binaries ###
TAR="$(which tar)"
GZIP="$(which gzip)"
FTP="$(which ftp)"

## Today + hour in 24h format ###
NOW=$(date +%Y%m%d)


### Create tmp dir ###
mkdir $BACKUP/$NOW

### Here you can add or delete directories you wish to backup.
### They will be set to *.gz file
$TAR -cf $BACKUP/$NOW/apache2.tar /etc/apache2
$TAR -cf $BACKUP/$NOW/www.tar /var/www
$TAR -cf $BACKUP/$NOW/mysqldump.tar /var/mysqldump-secure
$TAR -cf $BACKUP/$NOW/mysqldump-secure.tar /etc/mysqldump-secure.conf /etc/mysqldump-secure.cnf
$TAR -cf $BACKUP/$NOW/php5.tar /etc/php/5.6
$TAR -cf $BACKUP/$NOW/odbcinstini.tar /etc/odbcinst.ini
$TAR -cf $BACKUP/$NOW/ntpd.tar /etc/openntpd/ntpd.conf
$TAR -cf $BACKUP/$NOW/sshd.tar /etc/ssh/sshd_config
$TAR -cf $BACKUP/$NOW/fail2ban.tar /etc/fail2ban
$TAR -cf $BACKUP/$NOW/phpmyadmin.tar /etc/phpmyadmin
$TAR -cf $BACKUP/$NOW/letsencrypt.tar /etc/letsencrypt
$TAR -cf $BACKUP/$NOW/home.tar /home/irep --exclude='/home/irep/backups' --exclude='/home/irep/.viminfo' --exclude='/home/irep/.nano_history' --exclude='/home/irep/.mysql_history' --exclude='/home/irep/.emacs'


ARCHIVE=$BACKUP/iREP-JVF-$NOW.tar.gz
ARCHIVED=$BACKUP/$NOW

$TAR -zcvf $ARCHIVE $ARCHIVED

### upload backup to NAS809 ###
cd $BACKUP
DUMPFILE=iREP-JVF-$NOW.tar.gz
$FTP -in $FTPS <<END_SCRIPT
quote USER $FTPU
quote PASS $FTPP
passive
cd $FTPD
mput $DUMPFILE
bye
END_SCRIPT

### deleting temp files ###
rm -r $ARCHIVED
rm -r $DUMPFILE
echo "Backup finished and transferred for iREP-JVF"
exit
