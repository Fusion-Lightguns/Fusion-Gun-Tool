#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="LINUX FUSION GUN TOOL"


function fusion-gun-tool()  {
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

function gun-tool-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "FUSION LIGHTGUN TOOL" \
      --ok-label Select --cancel-label Exit \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "Play Calibration Video" \
      2 "Show Fusion Phaser Mappings" \
      3 "Show Fusion Volt Mappings" \
      2>&1 >/dev/tty)
      
     case "$choice" in
     1) cali-video ;;
     2) phaser-buttons ;;
     3) volt-buttons ;;
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

function cali-video() {
omxplayer "$HOME"/Fusion-Gun-Tool/Fusion-Gun-Tool-Video.mp4 > /dev/null 2>&1
}

function phaser-buttons() {
dialog  --sleep 1 --title "FUSION PHASER MAPPINGS" --msgbox " 
 On The Lightgun (In Code)-------------Keyboard button
 
 - Trigger ----------------------------Mouse 1
 
 - L Side Button 1 (Start) -------------Alt (mouse 2 if no slide)
 
 - L Side Button 2 (Select) ------------F4
 
 - R Side Button 1 (A Key) -------------Return
 
 - R Side Button 2 (B Key) -------------Escape
      
 - Slide grip -------------------- Mouse 2 (in the works)" 0 0
}

function volt-buttons() {
dialog  --sleep 1 --title "FUSION VOLT MAPPINGS" --msgbox " 

 On The Lightgun (In Code)-------------Keyboard button
 
 - Trigger ----------------------------Mouse 1
 
 - Back Button (Reload) ----------------Mouse 2

 - L Side Button 1 (Start) -------------Alt
 
 - L Side Button 2 (Select) ------------F4
 
 - R Side Button 1 (A Key) -------------Return
 
 - R Side Button 2 (B Key) -------------Escape" 0 0

}


fusion-gun-tool
