#!/usr/bin/bash 
# Created by Chaz Davis on 2020-04-18
# rofi-power
# Use rofi to call systemctl for shutdown, reboot, etc

OPTIONS="Reboot system\nPower-off system\nSuspend system\nHibernate system"

LAUNCHER="rofi -dmenu -i -p rofi-power:"
USE_LOCKER="false"
LOCKER="$HOME/.config/rofi/scripts/lockscreen.sh"

# Show exit wm option if exit command is provided as an argument
if [ ${#1} -gt 0 ]; then
  OPTIONS="Exit window manager\n$OPTIONS"
fi

option=$(echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n')
if [ ${#option} -gt 0 ]; then
  case $option in
  Exit)
    echo 'awesome.quit()' | awesome-client
    ;;
  Reboot)
    systemctl reboot
    ;;
  Power-off)
    systemctl poweroff
    ;;
  Suspend)
    $($USE_LOCKER) && "$LOCKER"
    systemctl suspend
    ;;
  Hibernate)
    $($USE_LOCKER) && "$LOCKER"
    systemctl hibernate
    ;;
  *) ;;

  esac
fi
