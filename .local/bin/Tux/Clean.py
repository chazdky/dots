#!/usr/bin/python3
import argparse
import os
import fnmatch
from Tux.TuxFunctions import file_seperator, file_create, return_file_list, find_dest_path, confirm_dest_path, separate_file_types, find_book_paths, move_file, open_in_editor, show_dest_file_list



class Clean:

    def __init__(self, command, srcPath, ignoredFiles):
        self.name = command
        self.srcPath = srcPath
        self.ignoredFiles = ignoredFiles

        print('Gathering files...')
        print(f'The Directory you would like to clean is {srcPath}, excluding any files like {ignoredFiles}')
        print()
        # find the files to be moved
        file_list = return_file_list(srcPath, ignoredFiles)
        
        # ask the user if theyd like to view the list of files to be moved
        choice = input('Would you like to view the list of files to be cleaned and sorted? \nEnter y for yes:  ')
        print()
        if choice.lower() == 'y':
            print(file_list)
        else:
            pass
        print()
        print()
        decide = input('Would you like to see each file and confirm whether it gets moved? \nEnter y for yes:  ')
        print()
        print()
        # now that file list has been create lets work with the files                    
        print('Starting the sort')
        print()
        print()
        for file in file_list:
            fileType = separate_file_types(file)
            destPath = find_dest_path(fileType, file)
            if decide.lower() == 'y':
                print()
                print()
                confirm = input(f'Would you like to move {file} to {destPath}?   ')
                print()
                print()
                if confirm.lower() == 'y':
                    confirm_dest_path(destPath)
                    move_file(srcPath, destPath, file)
                else:
                    pass
            else:
                confirm_dest_path(destPath)
                move_file(srcPath, destPath, file)
        
