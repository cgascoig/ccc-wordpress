#!/bin/bash

source /usr/local/osmosix/etc/userenv

WPDIR="/var/www/ccc-wordpress-${GIT_TAG}/wordpress"
FILENAME="${WPDIR}/wp-config.php"
shift

echo "Replacing tokens in $FILENAME"

for VARNAME in "DB_USER" "DB_PASSWORD" "DB_NAME"
do
	echo "  replacing %$VARNAME% with '${!VARNAME}'"
	sed -e "s/%$VARNAME%/${!VARNAME}/g" --in-place=.bak $FILENAME
done

ln -s $WPDIR /var/www/wp