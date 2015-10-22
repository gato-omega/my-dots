#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
apps=(
  # shimo                # VPN client http://www.feingeist.io/shimo/
  # 1password            # password manager https://agilebits.com/onepassword
  alfred               # Alfred
  dropbox              # Dropbox
  google-chrome        # Google Chrome browser
  google-chrome-canary # Google Chrome Canary

  #### Quicklook Enhancements Begin

  # qlcolorcode
  # qlstephen
  # qlmarkdown
  # quicklook-json
  # qlprettypatch
  # quicklook-csv
  # betterzipql
  # webpquicklook
  # suspicious-package

  #### Quicklook Enhancements End

  # gmail
  # screenflick          # Video/desktop recording software http://www.araelium.com/screenflick
  slack                # Slack(#)
  # transmit             # SFTP client and more https://panic.com/transmit/
  # appcleaner           # Cleans files and apps http://www.macupdate.com/app/mac/25276/appcleaner
  # firefox              # Firefox browser
  # hazel                # Automatic filing https://www.noodlesoft.com/hazel.php
  # seil                 # Change CAPS-LOCK key (e.g. to ESC), https://github.com/tekezo/Seil
  # karabiner            # Keyboard mappings customizer https://github.com/tekezo/Karabiner
  # spotify
  # vagrant              # Vagrant
  # arq                  # Backup tool https://www.arqbackup.com/
  # flash                # Adobe Flash https://github.com/caskroom/homebrew-cask/blob/master/Casks/flash.rb
  iterm2               # iTerm2 terminal replacement app
  # shiori               # Pinboard and Delicious OS X client http://aki-null.net/shiori/
  sublime-text         # Sublime Text 2
  # sublime-text3        # Sublime Text 3
  virtualbox           # Virtualbox
  # atom                 # Atom text/code editor
  flux                 # Human friendly screen luminosity https://justgetflux.com/
  # mailbox
  # sketch              # Digital design app, http://www.sketchapp.com/
  # tower               # git client http://www.git-tower.com
  # vlc                 # VLC (Video Lan Player)
  # cloudup             # Share stuff https://cloudup.com
  # nvalt               # Some app to write quicker http://brettterpstra.com/projects/nvalt/
  skype               # Skype
  # transmission        # BitTorrent Client http://www.transmissionbt.com/
  # cyberduck           # Libre FTP, SFTP, WebDAV, S3, Azure & OpenStack Swift browser https://cyberduck.io/
  quicksilver         # Progressive autolearning shortcuts for OS X http://qsapp.com/
  imageoptim          # Lossless in-place image compression https://imageoptim.com/
  # sequel-pro          # MySQL management app http://www.sequelpro.com/
  spectacle          # Keyboard shortcuts for window management https://github.com/eczarny/spectacle
  screenflow          # Video editing software http://telestream.net/screenflow/overview.htm
  gimp               # GIMP, Image editing software
)

# fonts
fonts=(
 # font-sauce-code-powerline
 # font-m-plus
 # font-clear-sans
 # font-roboto
 font-inconsolata
)

# Atom packages # - not using atom right now
atom=(
  # advanced-railscasts-syntax
  # atom-beautify
  # cmd-9
  # color-picker
  # css-comb
  # docblockr
  # easy-motion
  # editor-stats
  # emmet
  # fancy-new-file
  # file-icons
  # git-history
  # highlight-selected
  # image-view
  # inc-dec-value
  # key-peek
  # language-jade
  # linter
  # markdown-preview
  # merge-conflicts
  # neutron-ui
  # npm-install
  # react
  # vim-mode
  # zentabs
)

# Specify the location of the apps
# appdir="/Applications" # this seems to be the default? # we will see

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  # brew tap phinze/homebrew-cask # old commands?
  # brew reinstall brew-cask      # old commands?

  # Tap alternative versions https://github.com/caskroom/homebrew-versions
  # this lets you install previous versions of apps
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts
  # See https://github.com/caskroom/homebrew-cask, now it is installed as:
  set +e
  brew install caskroom/cask/brew-cask
  set -e


  # install apps
  echo "installing apps with brew cask..."
  brew cask install ${apps[@]}
  # brew cask reinstall --appdir=$appdir ${apps[@]} # do not install in /Applications
  # brew cask reinstall --appdir=$appdir ${apps[@]} # the reinstall subcommand exists?

  # restart quicklook manager for quicklook (ql) enhancements to take effect
  qlmanage -r

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}
  # install mackup
  # echo "installing mackup..."
  # pip install mackup

  # install atom plugins
  # echo "installing atom plugins..."
  # apm install ${atom[@]}

  # homebrew cask link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
