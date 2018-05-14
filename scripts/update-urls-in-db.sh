#!/bin/bash

. /usr/local/osmosix/etc/.osmosix.sh
. /usr/local/osmosix/etc/userenv
. /usr/local/osmosix/service/utils/cfgutil.sh

mysql -u $DB_USER -p$DB_PASSWORD -e "update wordpress.wp_options set option_value = 'http://${CliqrTier_nginx_1_PUBLIC_IP}/${cliqrWebappAccessLink}' where option_name = 'siteurl';"
mysql -u $DB_USER -p$DB_PASSWORD -e "update wordpress.wp_options set option_value = 'http://${CliqrTier_nginx_1_PUBLIC_IP}/${cliqrWebappAccessLink}' where option_name = 'home';"
