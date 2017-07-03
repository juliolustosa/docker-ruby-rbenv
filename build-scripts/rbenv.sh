#!/bin/bash
#author		 :Julio Lustosa
set -e

## Install rbenv
export RBENV_ROOT="/home/$USER/.rbenv"
mkdir -p $RBENV_ROOT
git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
cd $RBENV_ROOT && src/configure && make -C src
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

## Install ruby-build
git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
export PATH="$RBENV_ROOT/plugins/ruby-build/bin:$PATH"

## Install Ruby Versions
IFS=', ' read -r -a versions <<< $RUBY_VERSIONS
for ruby_version in "${versions[@]}"
do
    rbenv install $ruby_version && rbenv rehash
    echo "Ruby $ruby_version Installed"
done

## Set default ruby version
rbenv global $RUBY_VERSION_DEFAULT && rbenv rehash
echo "Ruby version default is $RUBY_VERSION_DEFAULT"
echo ruby -v