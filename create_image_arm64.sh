#!/bin/bash

# create docker image
cd rstudio-shiny-docker
docker build -t rserver:first . -f Dockerfile.arm64