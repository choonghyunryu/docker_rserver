#!/bin/bash

# create docker container
docker run -d -p 3838:3838 -p 8787:8787 -p 80:80 \
  -e PASSWORD=rstudio -e ROOT=TRUE -e TZ=Asia/Seoul -e LANG=ko_KR.UTF-8 \
  --name rstudio-shiny-server \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/shiny-server/:/srv/shiny-server/ \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/web/html/:/var/www/html/ \
  -v /Users/choonghyunryu/Documents/01_Personal/15_demos/logs/shiny/:/var/log/shiny-server/ \
  rserver:second 
