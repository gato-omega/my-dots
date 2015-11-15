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
brew update
show_status "Updating homebrew" "$?"

set +e

echo "Installing coreutils, findutils, bash v4 and grep (dupe)"

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
show_status "Installing GNU coreutils" "$?"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
show_status "Installing findutils" "$?"

# Install Bash 4
brew install bash
show_status "Installing Bash" "$?"

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep
show_status "Installing dupes' grep" "$?"

set -e

# Install other useful binaries
binaries=(
  ack
  tree                # output directory and file structure in the console
  the_silver_searcher # 'ag' commandline tool (a better grep)
  git                 # git
  hub                 # git+hub (from Github)
  fasd                # Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v, https://github.com/clvv/fasd
  postgres            # Postgres
  # phantomenv          # PhantomJS version manager (rbenv for phantomjs) # better to just enabled on its own
  jenv                # java version manager (rbenv for java) [javas must be manually added]
  qt                  # qt lib
  imagemagick       # watch out for graphicsmagick possible conflicts with executables, http://www.graphicsmagick.org/utilities.html
  pkgconfig           # or pkg-config? is an utility that reads metadata in order to correctly install components at compile time (gcc)
  # graphicsmagick      # imagemagick alternative, provides some of the same executables
  # boot2docker
  # webkit2png
  # rename
  # zopfli
  # ffmpeg
  # python
  # mongo
  # sshfs
  # trash
  # node
)

# Install the binaries
set +e # If already installed, non-zero status error is reported, skip that
brew install ${binaries[@]}
show_status "Installing brew binaries" "$?"
set -e # revert back to errors aborting the entire script

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
