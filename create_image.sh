#!/bin/bash

# create docker image
docker build --platform linux/amd64 -t rserver:first ./rstudio-shiny-docker