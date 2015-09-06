#!/usr/bin/env bash
set -eu

source "$lib/utils/display.sh"

# modules
source "$lib/symlink/index.sh"
show_status "Sourcing $lib/symlink/index.sh"  $?
source "$lib/is-osx/index.sh"
show_status "$lib/is-osx/index.sh"  $?


# Only run if on a Mac
if [[ 0 -eq `osx` ]]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
echo "bef def"
sh "$osx/defaults.sh"
echo "aft def"
show_status "Sourcing $osx/defaults.sh"  $?
sh "$osx/binaries.sh"
show_status "$osx/binaries.sh" $?
exit 0
sh "$osx/apps.sh"

# Symlink the profile
if [[ ! -e "$HOME/.bash_profile" ]]; then
  echo "symlinking: $osx/profile.sh => $HOME/.bash_profile"
  symlink "$osx/profile.sh" "$HOME/.bash_profile"
  source $HOME/.bash_profile
else
  echo "$HOME/.bash_profile already exists. remove and run again."
fi

