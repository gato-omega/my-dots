#!/usr/bin/env bash
set -eu

install_dots() {
# paths
dir=$(dirname $0)
lib="/usr/local/lib"
bin="/usr/local/bin"

# make in case they aren't already there
sudo mkdir -p $lib
sudo mkdir -p $bin

# Copy the path
sudo cp -R $dir "$lib/"

# remove existing bin if it exists
if [ -e "$bin/dots" ]; then
  rm "$bin/dots"
fi

# symlink dots
ln -s "$lib/dots/dots.sh" "$bin/dots"

}

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}****************************************************************************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Install dots                                                                      **${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Run dots boot                                                                     **${NORMAL}"                                                                                           
    echo -e "${MENU}****************************************************************************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}
function parse_choice() {
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "Install dots";
        install_dots
        show_menu;
        ;;

        2) clear;
            option_picked "Run dots boot";
            dots boot osx
        show_menu;
            ;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
}

printf '\e[8;30;100t'
clear

show_menu
parse_choice



