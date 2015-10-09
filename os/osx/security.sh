#!/usr/bin/env bash

###############################################################################
# Security settings, see https://github.com/drduh/OS-X-Yosemite-Security-and-Privacy-Guide
###############################################################################

# from https://github.com/kfinlay/dots/commit/d6d71e257f1313d5fb7e62d4448935db65191f44
set -eu
echo "security"
source $SHELL_LIBRARY_PATH/modules/avoidDoubleImport.sh
source $SHELL_LIBRARY_PATH/utils/display.sh
# if already enabled no worries
set +e
sudo fdesetup enable
show_status "Enabling FileVault 2" "$?"
set -e

echo "Enabling Application Level Firewall..."

sudo defaults write /Library/Preferences/com.apple.alf \ globalstate -int 1
show_status "  Enabling Firewall by default" "$?"
sudo defaults write /Library/Preferences/com.apple.alf \ allowsignedenabled -bool false
show_status "  allowsignedenabled -bool false" "$?"
sudo defaults write /Library/Preferences/com.apple.alf \ loggingenabled -bool true
show_status "  loggingenabled -bool true" "$?"
sudo defaults write /Library/Preferences/com.apple.alf \ stealthenabled -bool true
show_status "  Stealth mode enabled (computer does not broadcast itself to the network) when firewall up" "$?"

# echo "Privacy settings for OS X" # Skipped, was read
# curl -O https://fix-macosx.com/fix-macosx.py && /usr/bin/python fix-macosx.py
