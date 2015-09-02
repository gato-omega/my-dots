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
 
