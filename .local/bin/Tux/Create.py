#!/usr/bin/python3
import argparse
import os
from Tux.TuxFunctions import file_seperator, file_create, return_file_ext, confirm_dest_path, separate_file_types, find_book_paths, move_file, open_in_editor, show_dest_file_list

Home = os.path.expandvars('$HOME')

class Create:

    def __init__(self, command, baseName, fileType, destPath):
        self.name = command
        self.baseName = baseName
        self.fileType = fileType
        self.destPath = destPath

        scriptsDir = os.path.join(Home, 'Documents/Scripts')
        practiceScriptsDir = os.path.join(scriptsDir, 'PracticeScripts')
        
        if destPath == 'cwd':
            destPath = destPath
        if destPath == 'Scripts':
            destPath = scriptsDir
        if destPath == 'PracticeScripts':
            destPath = practiceScriptsDir

        fileExt = return_file_ext(fileType)
        os.chdir(destPath)
        fileName = file_create(baseName, fileExt, fileType)
        open_in_editor(fileName)

