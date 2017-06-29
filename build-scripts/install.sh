#!/bin/bash
set -e

## Add new user
bash /build-scripts/add-user.sh

## Install Yarn
bash /build-scripts/yarn.sh

## Install RBENV
bash /build-scripts/rbenv.sh

## Clear all
bash /build-scripts/clear.sh