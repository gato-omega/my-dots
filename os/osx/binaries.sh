#!/usr/bin/env bash
set -eu
echo "binaries"
source $SHELL_LIBRARY_PATH/modules/avoidDoubleImport.sh
source $SHELL_LIBRARY_PATH/utils/display.sh

#
# Binary installer
#

# Check for Homebrew
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  show_status "Installing homebrew" "$?"
fi

# Update homebrew
brew update && brew reinstall brew-cask
show_status "Updating homebrew" "$?"

# Install GNU core utilities (those that come with OS X are outdated)
brew reinstall coreutils
show_status "Installing GNU coreutils" "$?"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew reinstall findutils
show_status "Installing findutils" "$?"

# Install Bash 4
brew reinstall bash
show_status "Installing Bash" "$?"

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew reinstall homebrew/dupes/grep
show_status "Installing dupes' grep" "$?"
# Install other useful binaries
binaries=(
#  graphicsmagick
#  boot2docker
#  webkit2png
#  phantomjs
#  rename
#  zopfli
#  ffmpeg
  python
#  mongo
#  sshfs
#  trash
#  node
#  tree
#  hub
#  ack
  git
#  hub
#  fig
#  go
)

# Install the binaries
brew install ${binaries[@]}
show_status "Installing brew binaries" "$?"

# Add osx specific command line tools
#if test ! $(which subl); then
#  ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
#fi

# Install spot
#if test ! $(which spot); then
#  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
#fi

# Create a $GOPATH
#mkdir -p $HOME/Go

# Remove outdated versions from the cellar
brew cleanup

exit 0
