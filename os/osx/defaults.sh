#!/usr/bin/env bash 

. $SHELL_LIBRARY_PATH/importUtils.sh

set -eu 

# OSX for Hackers (Mavericks/Yosemite) 
# 
# Source: https://gist.github.com/brandonb927/3195465 
# Some things taken from here 
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx 

# Ask for the administrator password upfront 
sudo -v 

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished 
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null & 

echo "This script will make your Mac awesome" 

############################################################################### 
# General UI/UX 
############################################################################### 
import "generalUI"

generalUI__disableGK
generalUI__saveToDisk
generalUI__dailySoftUpdate

############################################################################### 
# Trackpad, mouse, keyboard, Bluetooth accessories, and input 
############################################################################### 
import "inputOutput"

inputOutput__incrBluetoothSound
inputOutput__disableAutoCorrect
inputOutput__keyboardLightSleep

############################################################################### 
# Screen 
############################################################################### 
import "screen"

screen__passwordRequiredAfterSleep


############################################################################### 
# Finder 
############################################################################### 
import "finder"

finder__showFileExtensions
finder__showStatusBar
finder__disableExtChangeWarn
finder__columnView
finder__avoidDSStoreOnNetwork


############################################################################### 
# Dock & Mission Control 
############################################################################### 
import "dock"

dock__iconSize
dock__speedUpMCAnim


############################################################################### 
# Safari & WebKit 
############################################################################### 
import "safari"

safari__backspaceToPrevious

############################################################################### 
# Mail 
############################################################################### 
import "mail"

mail__copyShortAdress

############################################################################### 
# Spotlight                                                                   # 
############################################################################### 
#import "spotlight"


############################################################################### 
# Terminal & iTerm 2  
############################################################################### 
import "term"

term__disableQuitPrompt

############################################################################### 
# Time Machine 
############################################################################### 
import "timeMachine"

timeMachine__disableUseNewDrivePrompt
timeMachine__disableLocalBackup

############################################################################### 
# Messages                                                                    # 
############################################################################### 
import "message"

message__disableSpellChecking

############################################################################### 
# Personal Additions 
############################################################################### 
import "misc"

misc__disableMotionSensor


############################################################################### 
# Kill affected applications 
############################################################################### 
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \ 
	"Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \ 
	"Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" "Terminal" \ 
	"Transmission" "Twitter" "iCal"; do 
	killall "${app}" > /dev/null 2>&1 
done 
echo "Done. Note that some of these changes require a logout/restart to take effect." 
 
