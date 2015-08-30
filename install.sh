#!/usr/bin/env bash
set -eu

COLUMNS=$(tput cols)
printf '\e[8;50;100t'


install_dots() {
show "Will now install dots to /usr/local/bin"
move_on



# make in case they aren't already there

sudo mkdir -p $lib
show_status "Creating $lib" $?


sudo mkdir -p $bin
show_status "Creating $bin" $?

# Copy the path

sudo cp -R $dir "$lib/"
show_status "Copying $dir to $lib" $?

# remove existing bin if it exists
if [ -e "$bin/dots" ]; then
  rm "$bin/dots"
  show_status "Removing existing $bin/dots" $?
fi

# symlink dots

ln -s "$lib/dots/dots.sh" "$bin/dots"
show_status "Symlinking $lib/dots/dots.sh to $bin/dots"  $?
}

move_on() {
read -p "Do you want to continue? " -n 1 -r

if [ ! [ $REPLY == ^[Yy] ] ]
then
    exit 0
else
   clear
fi
}

# paths
dir=$(dirname $0)
lib="/usr/local/lib"
bin="/usr/local/bin"

source $dir/lib/utils/display.sh


install_dots
dots boot osx




