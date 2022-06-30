#!/bin/bash
set -e

# create init scripts
mkdir -p /etc/services.d/dsub
cat <<"EOF" >/etc/services.d/dsub/run
#!/usr/bin/with-contenv bash
## load /etc/environment vars first:
for line in $( cat /etc/environment ) ; do export $line > /dev/null; done

exec service dbus start 2>&1
EOF
chmod +x /etc/services.d/dsub/run
