#!/bin/bash
#iREP server - [cronjobs]

function brew_cronjobs() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/intellect/reagents"

  echo "Brewing cronjobs..."

  if [ "$ENV" == "MTL" ]
  then
  crontab -u irep -r
  crontab -u irep -l | { cat; echo "20 4 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "30 4 * * * /usr/bin/php /var/www/toolshed/odbc-fetcher.php > /var/www/logs/odbc-fetcher.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "40 4 * * * /usr/bin/php /var/www/toolshed/agreementHistory.php > /var/www/logs/agreementHistory.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "50 4 * * * /usr/bin/mysqldump-secure --cron 2> /var/www/logs/mysqldump.log"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "00 5 * * * /bin/sh $REAGENTS/backup/iREP-MTL/irep-backup.sh > /var/www/logs/irep-backup.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "30 5 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "10,30,50 * * * * /usr/bin/php /var/www/toolshed/assembler.php > /var/www/logs/assembler.log 2>&1"; } | sort - | uniq - | crontab -
  echo "cronjobs are now installed..."
  crontab -u irep -l

  #sudo cronjobs
  echo "installing sudo cronjobs..."
  echo "@reboot root /bin/sh $REAGENTS/mnt_network_drive.sh > /var/www/logs/mnt_network_drive.log 2>&1" > ~/mnt_network_drive.cron
  sudo cp ~/mnt_network_drive.cron /etc/cron.d/mnt_network_drive
  rm ~/mnt_network_drive.cron
  echo "30 2 * * 1 certbot renew >> /var/log/le-renew.log" > ~/le-renew.cron
  sudo cp ~/le-renew.cron /etc/cron.d/le-renew
  rm ~/le-renew.cron

  elif [ "$ENV" == "InDev" ]
  then
  crontab -u dev -r
  crontab -u dev -l | { cat; echo "10 05 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u dev -l | { cat; echo "15 05 * * * /usr/bin/php /var/www/toolshed/odbc-fetcher.php > /var/www/logs/odbc-fetcher.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u dev -l | { cat; echo "20 05 * * * /usr/bin/php /var/www/toolshed/agreementHistory.php > /var/www/logs/agreementHistory.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u dev -l | { cat; echo "30 05 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  #crontab -u dev -l | { cat; echo "*/5 * * * * /usr/bin/php /var/www/toolshed/trailBlazer/trailBlazer.php > /var/www/logs/trailBlazer.log 2>&1"; } | sort - | uniq - | crontab - #test & remove
  echo "cronjobs are now installed..."
  crontab -u dev -l

  #sudo cronjobs
  echo "installing sudo cronjobs..."
  echo "@reboot root /bin/sh $REAGENTS/mnt_network_drive.sh > /var/www/logs/mnt_network_drive.log 2>&1" > ~/mnt_network_drive.cron
  sudo cp ~/mnt_network_drive.cron /etc/cron.d/mnt_network_drive
  rm ~/mnt_network_drive.cron

  elif [ "$ENV" == "JVF" ]
  then
  crontab -u irep -r
  crontab -u irep -l | { cat; echo "20 4 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "10 17 * * * /usr/bin/php /var/www/toolshed/odbc-fetcher.php > /var/www/logs/odbc-fetcher.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "35 4 * * * /usr/bin/php /var/www/toolshed/odbc-fetcher.php > /var/www/logs/odbc-fetcher.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "40 4 * * * /usr/bin/php /var/www/toolshed/agreementHistory.php > /var/www/logs/agreementHistory.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "50 4 * * * /usr/bin/mysqldump-secure --cron 2> /var/www/logs/mysqldump.log"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "00 5 * * * /bin/sh $REAGENTS/backup/iREP-JVF/irep-backup.sh > /var/www/logs/irep-backup.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "30 5 * * * /usr/bin/php /var/www/toolshed/janitor.php > /var/www/logs/janitor.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "*/10 * * * * /usr/bin/php /var/www/toolshed/assembler.php > /var/www/logs/assembler.log 2>&1"; } | sort - | uniq - | crontab -
  crontab -u irep -l | { cat; echo "*/5 * * * * /usr/bin/php /var/www/toolshed/trailBlazer/trailBlazer.php > /var/www/logs/trailBlazer.log 2>&1"; } | sort - | uniq - | crontab -
  echo "cronjobs are now installed..."
  crontab -u irep -l

  #sudo cronjobs
  echo "installing sudo cronjobs..."
  echo "@reboot root /bin/sh $REAGENTS/mnt_network_drive.sh > /var/www/logs/mnt_network_drive.log 2>&1" > ~/mnt_network_drive.cron
  sudo cp ~/mnt_network_drive.cron /etc/cron.d/mnt_network_drive
  rm ~/mnt_network_drive.cron
  echo "30 2 * * 1 certbot renew >> /var/log/le-renew.log" > ~/le-renew.cron
  sudo cp ~/le-renew.cron /etc/cron.d/le-renew
  rm ~/le-renew.cron

  fi

}
