#!/bin/bash
set -e

## Create a user for the web app.
addgroup --gid 9999 $USER
adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" $USER
usermod -L $USER
mkdir -p /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chown $USER:$USER /home/$USER/.ssh