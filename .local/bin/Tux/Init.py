#!/usr/bin/python3
import argparse
import os
import shutil

Home = os.path.expandvars('$HOME')

class Init:

    def __init__(self, command, fileName):
        self.name = command
        self.fileName = fileName
       
        srcPath = os.path.join(os.getcwd(), fileName)
        baseName = os.path.splitext(fileName)[0]
        destPath = Home + '/.local/bin'
        fullDest = f'{destPath}/{baseName}'
        shutil.copy(srcPath, fullDest)
        os.chdir(destPath)
        os.stat(fullDest)
        os.chmod(fullDest, 0o751)
        

