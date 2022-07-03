#!/bin/bash

set -e

#------------------------------------------
# R User account for RStudio & Shiny
#------------------------------------------

R_USER=${R_USER:=ruser}
R_USER_PWD=${R_USER_PWD:=rworld}

adduser ${R_USER} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password --force-badname
echo "${R_USER}:${R_USER_PWD}" | chpasswd

# Set up to use the R package library (/usr/local/lib/R/site-library)
addgroup ${R_USER} staff

# Grant sudo privileges to the user
usermod -aG sudo ${R_USER}

echo -e LANG=en_US.UTF-8 > /home/${R_USER}/.Renviron

# For install tex packages by ruser account
chown -R ${R_USER} /usr/local/texlive/
