#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="LINUX FUSION GUN TOOL"


function fusion-gun-tool
if [ ! -d "$HOME/Fusion-Gun-Tool" ]; then gun-tool-error ; else gun-tool-menu; fi
} 

function gun-tool-error() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "FUSION LIGHTGUN TOOL NOT INSTALLED" \
      --ok-label Select --cancel-label Exit \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "Yes Install Gun Tool" \
      2 "No Dont Install Tool" \
      2>&1 >/dev/tty)
      
     case "$choice" in
     1) install-gun-tool ;;
     2) exit ;;
     -) no ;;
     *) break ;;
    esac
   done
}
      
function install-gun-tool() {
mkdir "$HOME"/Fusion-Gun-Tool/
wget https://raw.githubusercontent.com/Fusion-Lightguns/Fusion-Gun-Tool/main/Fusion-Gun-Tool-Pic.png -P "$HOME"/Fusion-Gun-Tool/
wget https://github.com/Fusion-Lightguns/Fusion-Gun-Tool/raw/main/Fusion-Gun-Tool-Video.mp4 -P "$HOME"/Fusion-Gun-Tool/
}


fusion-gun-tool
