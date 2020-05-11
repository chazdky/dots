#!/usr/bin/env python3
# Created by Chaz Davis on 2020-01-19

import argparse
import os
from os import path
from dynmen import Menu
import subprocess


class Open:
    def __init__(self, command, path):
        self.name = command
        self.path = path

        Home = os.path.expandvars("$HOME")
        NotesDir = os.path.join(Home, "Notes")
        JournalDir = os.path.join(NotesDir, "Journal")
        EngineeringJournalDir = os.path.join(NotesDir, "EngineeringJournal")
        CIT167Dir = os.path.join(EngineeringJournalDir, "CIT167")
        CIT218Dir = os.path.join(EngineeringJournalDir, "CIT218")
        CIT288Dir = os.path.join(EngineeringJournalDir, "CIT288")

        if path == "all":
            pathDir = NotesDir
        if path == "journal":
            pathDir = JournalDir
        if path == "engineering":
            pathDir = EngineeringJournalDir
        if path == "ej167":
            pathDir = CIT167Dir
        if path == "ej218":
            pathDir = CIT218Dir
        if path == "ej288":
            pathDir = CIT288Dir

        files = []
        fileNames = []
        # r=root, d=directories, f = files
        for r, d, f in os.walk(pathDir):
            for file in f:
                if ".md" in file or ".tex" in file:
                    files.append(os.path.join(r, file))
                    fileNames.append(file)

        cmd = ["rofi", "-dmenu"]
        menu = Menu(cmd)
        out = menu(fileNames)
        result = out.selected

        for fn, fl in zip(fileNames, files):
            if result == fn:
                subprocess.run(["rofi-sensible-terminal", "-e", "nvim", fl])
            else:
                continue
