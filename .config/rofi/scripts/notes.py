#!/usr/bin/env python3
# Created by Chaz Davis on 2020-04-24
import os
from dynmen import Menu
import subprocess


def main():

    options = [all, journal, engineering, ej167, ej218, ej288]
    cmd = ["rofi", "-dmenu"]
    menu = Menu(cmd)
    out = menu(options)
    result = out.selected

    subprocess.run(["rofi-sensible-terminal", "-e", "note", "open", "--{option}"])


if __name__ == "__main__":
    main()
