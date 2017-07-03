#!/bin/bash
set -e

## Add new user
bash /build-scripts/add-user.sh

## Install Yarn
bash /build-scripts/yarn.sh