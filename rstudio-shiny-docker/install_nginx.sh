#!/bin/bash
set -e

# install web server
apt-get update && apt-get install -y nginx

cat <<"EOF" >> /etc/nginx/conf.d/nginx.conf  
# nginx.conf 파일
# 컨테이너 내부에 /etc/nginx/conf.d/nginx.conf 경로에 존재

server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
EOF

# create init scripts
mkdir -p /etc/services.d/nginx
cat <<"EOF2" >/etc/services.d/nginx/run
#!/usr/bin/with-contenv bash
## load /etc/environment vars first:
for line in $( cat /etc/environment ) ; do export $line > /dev/null; done

exec service nginx start 2>&1
EOF2
chmod +x /etc/services.d/nginx/run
