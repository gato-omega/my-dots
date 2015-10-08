#!/usr/bin/env bash

set -eu

# OSX for Hackers (Mavericks/Yosemite)
#
# Source: https://gist.github.com/brandonb927/3195465
# Some things taken from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

function getScriptAbsoluteDir {
    # @description used to get the script path
    # @param $1 the script $0 parameter
    local script_invoke_path="$1"
    local cwd=`pwd`

    # absolute path ? if so, the first character is a /
    if test "x${script_invoke_path:0:1}" = 'x/'
    then
        RESULT=`dirname "$script_invoke_path"`
    else
        RESULT=`dirname "$cwd/$script_invoke_path"`
    fi
}

script_invoke_path="$0"
script_name=`basename "$0"`
getScriptAbsoluteDir "$script_invoke_path"
script_absolute_dir=$RESULT

import() {
    # @description importer routine to get external functionality.
    # @description the first location searched is the script directory.
    # @description if not found, search the module in the paths contained in$SHELL_LIBRARY_PATH environment variable
    # @param $1 the .shinc file to import, without .shinc extension
    module=$1

    if test "x$module" == "x"
    then
        echo "$script_name : Unable to import unspecified module. Dying."
        exit 1
    fi

    if test "x${script_absolute_dir:-notset}" == "xnotset"
    then
        echo "$script_name : Undefined script absolute dir. Did you remove getScriptAbsoluteDir? Dying."
        exit 1
    fi

    if test "x$script_absolute_dir" == "x"
    then
        echo "$script_name : empty script path. Dying."
        exit 1
    fi

    if test -e "$script_absolute_dir/modules/$module.shinc"
    then
        # import from script directory
        . "$script_absolute_dir/modules/$module.shinc"
    elif test "x${SHELL_LIBRARY_PATH:-notset}" != "xnotset"
    then
        # import from the shell script library path
        # save the separator and use the ':' instead
        local saved_IFS="$IFS"
        IFS=':'
        for path in $SHELL_LIBRARY_PATH/modules
        do
            if test -e "$path/$module.shinc"
            then
                . "$path/$module.shinc"
                return
            fi
        done
        # restore the standard separator
        IFS="$saved_IFS"
    fi
    echo "$script_name : Unable to find module $module."
    exit 1
}

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "This script will make your Mac awesome"

###############################################################################
# Computer name setup
###############################################################################

echo ""
echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "What would you like it to be?"
  read COMPUTER_NAME
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi

###############################################################################
# General UI/UX
###############################################################################
import "generalUI"

# generalUI__removeIcons          # Just leave some of the icons on the top right
generalUI__disableGK            # No GateKeeper, allow all apps to be installed
# generalUI__incrWindResize       # Increase window resize speed for Cocoa apps
generalUI__expSavePanel         # Expanding the save panel by default
generalUI__autoQuitPrinter      # quit printer app when finished printing
# generalUI__showCtrlChars        # Visible ASCII control characters using caret notation in standard text views
# generalUI__disableSysResume     # Disable resume where you left off?
generalUI__disableAutoTerminate # manually require to kill inactive apps
generalUI__saveToDisk           # no write to iCloud, rather, save to disk (NSDocumentSaveNewDocumentsToCloud -bool false)
generalUI__hostInfoOnLogin      # Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
# generalUI__sleepModeOff         # turn off computer sleep for good?
generalUI__dailySoftUpdate      # check for software updates daily
generalUI__disableSmartQuotes   # Disable smart quotes and smart dashes as they're annoying when typing code


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################
import "inputOutput"

inputOutput__incrBluetoothSound  # Better bluetooth sound by increasing bitrate
inputOutput__fullKeyboardControl # (e.g. enable Tab in modal dialogs)
inputOutput__disablePressAndHold # no sticky keys?
inputOutput__keyboardFastRepeat  # e.g. fast backspace
inputOutput__disableAutoCorrect  # no autocorrect
inputOutput__trackpadSpeed       # set trackpad speed to a reasonable setting
inputOutput__keyboardLightSleep  # Sleep keyboard light after 5 minutes


###############################################################################
# Screen
###############################################################################
import "screen"

screen__passwordRequiredAfterSleep # Ask for password immediately
# screen__subpixFontRendering        # Enabling subpixel font rendering on non-Apple LCDs
# screen__hiDPIDisplay               # Enable HiDPI display modes (requires restart) [simulates retina's sharpness for non-retina screens]


###############################################################################
# Finder
###############################################################################
import "finder"

finder__showVolumeIconsOnDesk
finder__showFileExtensions
finder__showStatusBar
# finder__textSelectInPreview
finder__showPOSIXPath
finder__disableExtChangeWarn
finder__columnView
finder__avoidDSStoreOnNetwork
# finder__disableDiskImgCheck
# finder__snapToGridIcons


###############################################################################
# Dock & Mission Control
###############################################################################
import "dock"

dock__iconSize      # Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate
dock__speedUpMCAnim # Speeding up Mission Control animations and grouping windows by application
# dock__dockAutoHide  # Setting Dock to auto-hide and removing the auto-hiding delay

###############################################################################
# Safari & WebKit
###############################################################################
import "safari"

# safari__hideBookmrkBar
# safari__hideSideBar
safari__disableThumbCache      # Disabling Safari's thumbnail cache for History and Top Sites
safari__enableDebugMenu        # Enabling Safari's debug menu
safari__searchBannerContains   # Making Safari's search banners default to Contains instead of Starts With
safari__removeUselessBookmarks
safari__backspaceToPrevious
safari__enableDevMenu
safari__webInspectorCtxtMenu
safari__disableWebkit2Java
safari__disableWebkit2JavaLocalFiles

###############################################################################
# Mail
###############################################################################
import "mail"

mail__copyShortAddress

###############################################################################
# Spotlight                                                                   #
###############################################################################
# import "spotlight"

spotlight__disableIdxNewVolume
# spotlight__changeIndexingOrder


###############################################################################
# Terminal & iTerm 2
###############################################################################
import "term"

term__utf8Only
term__proTheme
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

# message__disableAutoEmoji
# message__disableSmartQuotes
message__disableSpellChecking

###############################################################################
# Personal Additions
###############################################################################
import "misc"

# misc__disableHibernate
# misc__removeSleepImage
misc__disableMotionSensor
misc__speedUpWakeFromSleep12
# misc__disableComputerSleep
# misc__disableChromeBackswipe


###############################################################################
# Kill affected applications
###############################################################################
#for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" "Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" "Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" "Terminal" "Transmission" "Twitter" "iCal"; do
#killall "${app}" > /dev/null 2>&1
#done
echo "Done. Note that some of these changes require a logout/restart to take effect."

