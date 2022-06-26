#!/bin/bash
set -e

# install web server
apt-get update && apt-get install -y \
  net-tools \
  iputils-ping \
  apache2

echo "ServerName localhost" >> /etc/apache2/apache2.conf  

# create init scripts
mkdir -p /etc/services.d/apache2
cat <<"EOF" >/etc/services.d/apache2/run
#!/usr/bin/with-contenv bash
## load /etc/environment vars first:
for line in $( cat /etc/environment ) ; do export $line > /dev/null; done

exec service apache2 start 2>&1
EOF
chmod +x /etc/services.d/apache2/run
