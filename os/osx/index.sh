#!/usr/bin/env bash
set -eu

source "$lib/utils/display.sh"

# modules
source "$lib/symlink/index.sh"
show_status "Sourcing $lib/symlink/index.sh"  $?
source "$lib/is-osx/index.sh"
show_status "$lib/is-osx/index.sh" $?


# Only run if on a Mac
if [[ 0 -eq `osx` ]]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
sh "$osx/defaults.sh"
show_status "Sourcing $osx/defaults.sh"  $?
sh "$osx/binaries.sh"
show_status "$osx/binaries.sh" $?
sh "$osx/apps.sh"
show_status "Sourcing $osx/apps.sh" $?
# cp $osx/dotfiles/* $HOME
# show_status "Copying dotfiles to $HOME" $?
sh "$osx/security.sh"
show_status "Sourcing $osx/security.sh" $?

sh "$osx/rbenv.sh"
show_status "Installing $osx/rbenv.sh" $?

echo "Setting Git to use Sublime Text as default editor"
git config --global core.editor "subl -n -w"

exit 0

# Use dotfiles for the rest, and/or change to dotfiles completely

# Symlink the profile -> use a different one instead
# if [[ ! -e "$HOME/.bash_profile" ]]; then
#   echo "symlinking: $osx/profile.sh => $HOME/.bash_profile"
#   symlink "$osx/profile.sh" "$HOME/.bash_profile"
#   source $HOME/.bash_profile
# else
#   echo "$HOME/.bash_profile already exists. remove and run again."
# fi

