#!/usr/bin/bash 
# Created by Chaz Davis on 2020-04-18

function get_color() {
  echo "$(xrdb -query | grep -i "color${1}:" | cut -f2)""CC"
}

if [ "$1" ]; then
  lockbg="$1"
else
  # lockbg=$(find $HOME/Pictures/wallpapers/*.png -type f | shuf -n 1)
  lockbg="$HOME/.config/awesome/themes/Chaz-X1C/wall.png"
fi

B=$(get_color 8)  # Blank
C=$(get_color 8)  # Clear ish
D=$(get_color 15) # Default
T=$(get_color 15) # Text
W=$(get_color 9)  # Wrong
H=$(get_color 12) # Highlight
V=$(get_color 4)  # Verifying

i3lock -n \
  --insidevercolor="$C" \
  --ringvercolor="$V" \
  --insidewrongcolor="$C" \
  --ringwrongcolor="$W" \
  --insidecolor="$B" \
  --ringcolor="$D" \
  --linecolor="$B" \
  --separatorcolor="$D" \
  --verifcolor="$T" \
  --wrongcolor="$T" \
  --timecolor="$T" \
  --datecolor="$T" \
  --layoutcolor="$T" \
  --keyhlcolor="$H" \
  --bshlcolor="$W" \
  --image="$lockbg" \
  --tiling \
  --keylayout 0 \
  --pass-media-keys \
  --timestr='%H:%M' \
  --time-font='sans Bold' \
  --date-font='sans Bold' \
  --timesize=48 \
  --datesize=18 \
  --indicator \
  --datestr="%A, %d %b" \
  --force-clock \
  --refresh-rate=30 \
  --radius=100 \
  --ring-width=5 \
  --veriftext='' \
  --wrongtext='' \
  --noinputtext='' \
  --locktext='' \
  --lockfailedtext='' \
  --show-failed-attempts \
  --ignore-empty-password
