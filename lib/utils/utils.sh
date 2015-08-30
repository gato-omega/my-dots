#!/usr/bin/env bash

show() {
 printf  "$1\n"
}

show_status() {
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
if [ $2 == 0 ]; then
status=$GREEN[OK]
else
status=[KO]
fi
line='..................................................................................'
txt=$1
printf "%s %s %s\n" "$NORMAL$txt" "${line:${#txt}}" "$status"

}

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

    if test -e "$script_absolute_dir/$module.shinc"
    then
        # import from script directory
        . "$script_absolute_dir/$module.shinc"
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