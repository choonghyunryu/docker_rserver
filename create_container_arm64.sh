#!/bin/bash

# create docker container
docker run -d -p 8787:8787 -p 80:80 \
  -e PASSWORD=rstudio -e ROOT=TRUE \
  --name rstudio-shiny-server \
  rserver:first 
