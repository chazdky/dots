#!/usr/bin/bash 
# Created by Chaz Davis on 2020-04-20
# Notes-open
# Use rofi to open files from my notes directory

OPTIONS="Notes Directory\nJournal Directory\nEngineering Journal Directory\nCIT167\nCIT218\nCIT288"

LAUNCHER="rofi -dmenu -i -p Directory to List:"
OPEN_COMMAND="note open"

option=$(echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n')
if [ ${#option} -gt 0 ]; then
  case $option in
  Notes)
    "$OPEN_COMMAND -a"
    ;;
  Journal)
    "$OPEN_COMMAND -j"
    ;;
  Engineering)
    "$OPEN_COMMAND -e"
    ;;
  CIT167)
    "$OPEN_COMMAND -e1"
    ;;
  CIT218)
    "$OPEN_COMMAND -e2"
    ;;
  CIT288)
    "$OPEN_COMMAND -e3"
    ;;
  *) ;;

  esac
fi
