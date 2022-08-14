#!/bin/bash

# create docker container
docker run -d -p 3838:3838 -p 8787:8787 -p 80:80 \
  -e PASSWORD=rstudio -e ROOT=TRUE \
  --name rstudio-shiny-server \
  -v shiny-server/app:/srv/shiny-server/ \
  -v web-server/html/:/var/www/html/ \
  -v shiny-server/log:/var/log/shiny-server/ \
  rserver:first 
