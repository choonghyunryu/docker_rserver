#!/bin/bash

# create docker image
cd rstudio-shiny-docker
docker build --platform linux/arm64/v8 -t rserver:first . -f Dockerfile.arm64