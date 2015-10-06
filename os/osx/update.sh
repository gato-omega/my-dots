#!/usr/bin/env bash
set -eu

# update OS X software packages
softwareupdate -ia

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update brew packages
brew update
brew upgrade

# cleanup
brew cleanup
