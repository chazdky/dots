#!/usr/bin/bash

# Simple script to handle a DIY shutdown menu. When run you should see a bunch of options (shutdown, reboot etc.)
#
# Requirements:
# - rofi
# - systemd, but you can replace the commands for OpenRC or anything else
#
# Instructions:
# - Save this file as power.sh or anything
# - Give it exec priviledge, or chmod +x /path/to/power.sh
# - Run it

iconpath="$HOME/.config/rofi//scripts/icons/"
text="Lock\0icon\x1f${iconpath}lock.png\n"
text="${text}Logout\0icon\x1f${iconpath}logout.png\n"
text="${text}Suspend\0icon\x1f${iconpath}suspend.png\n"
text="${text}Reboot\0icon\x1f${iconpath}reboot.png\n"
text="${text}Shutdown\0icon\x1f${iconpath}shutdown.png\n"
chosen=$(echo -en $text | rofi -dmenu -i)
# Info about some states are available here:
# https://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.html#Description

if [[ $chosen = "Lock" ]]; then
	betterlockscreen -l dimblur
elif [[ $chosen = "Logout" ]]; then
	echo 'awesome.quit()' | awesome-client
elif [[ $chosen = "Suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
fi
