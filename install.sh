#!/usr/bin/env bash
set -eu

COLUMNS=$(tput cols)
printf '\e[8;50;100t'

show() {
 printf  "$1\n"
}

show_status() {
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
if [ $2 == 0 ]; then
status=$GREEN[OK]
else
status=[KO]
fi
line='..................................................................................'
txt=$1
printf "%s %s %s\n" "$NORMAL$txt" "${line:${#txt}}" "$status"

}

install_dots() {
show "Will now install dots to /usr/local/bin"
move_on
# paths
dir=$(dirname $0)
lib="/usr/local/lib"
bin="/usr/local/bin"

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




install_dots
dots boot osx




