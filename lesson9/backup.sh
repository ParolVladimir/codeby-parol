#!/bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/opt/mysql_backup/$TIMESTAMP"
MYSQL_USER="root"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

mkdir -p "$BACKUP_DIR"

databases=`$MYSQL -u $MYSQL_USER -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)"`

for db in $databases; do
  $MYSQLDUMP -u $MYSQL_USER --databases $db > "$BACKUP_DIR/$db.sql"
done

