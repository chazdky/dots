#!/usr/bin/python3
import argparse
import os
import re
import fnmatch
from Tux.TuxFunctions import file_seperator, file_create, return_file_list, confirm_dest_path, separate_file_types, find_book_paths, find_dest_path, move_file, open_in_editor, show_dest_file_list

class SilentSort:

    def __init__(self, command, srcPath, ignoredFiles):
        self.name = command
        self.srcPath = srcPath
        self.ignoredFiles = ignoredFiles

        # find the files to be moved
        file_list = return_file_list(srcPath, ignoredFiles)
        
        # now that file list has been create lets work with the files                    
        for file in file_list:
            fileType = separate_file_types(file)
            destPath = find_dest_path(fileType, file)
            confirm_dest_path(destPath)
            move_file(srcPath, destPath, file)
