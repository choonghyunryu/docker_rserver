#!/bin/bash

# create docker container
docker run --platform linux/amd64 -d -p 3838:3838 -p 8787:8787 -p 80:80 \
  -e PASSWORD=rstudio -e ROOT=TRUE \
  --name rstudio-shiny-server \
  -v `pwd`/shiny-server/app:/srv/shiny-server/ \
  -v `pwd`/web-server/html/:/var/www/html/ \
  -v `pwd`/shiny-server/log:/var/log/shiny-server/ \
  rserver:first
