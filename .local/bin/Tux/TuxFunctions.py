#!/usr/bin/python3
import os

#function to seperate the base filename from the extension
def file_seperator(srcPath, fileName):
    import re
    import os.path
    extPattern = re.compile(r'[-_]')
    #seperate the baseName and ext from the file and return them to the program 
    baseName, baseExt = os.path.splitext(fileName)
    newExt = re.sub(extPattern, '', baseExt.lower())
    newBase = re.sub(" ", "", baseName.title())
    newFile = os.path.join(newBase, newExt)
    os.rename(fileName, newFile)
    return newFile

# function to create a new file given the name and passed in the args for file type
# TODO figure out how to put the template in the file
def file_create(baseName, fileExt, fileType):
    import os.path
    import datetime
    today = datetime.date.today()
    fileName = baseName + fileExt
    fileHeader = f'# Created by Chaz Davis on {today}'
    python_shebang = f'#!/usr/bin/env python3 \n{fileHeader}'
    bash_shebang = f'#!/usr/bin/bash \n{fileHeader}'
    rust_shebang = f'#!/usr/bin/env run-cargo-script \n{fileHeader}'
    altHeader = f'/* Created by Chaz Davis on {today} */'
    htmlHeader = f'<!--Created by Chaz Davis on {today}--->'
    markdownHeader = f'[//]: # (Created by Chaz Davis on {today})'

    if fileType == 'python':
        with open(fileName, 'a+') as f:
            f.writelines(python_shebang)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    if fileType == 'bash':
        with open(fileName, 'a+') as f:
            f.writelines(bash_shebang)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    if fileType == 'rust':
        with open(fileName, 'a+') as f:
            f.writelines(rust_shebang)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    if fileType == 'html':
        with open(fileName, 'a+') as f:
            f.writelines(htmlHeader)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    if fileType == 'yaml':
        with open(fileName, 'a+') as f:
            f.writelines(fileHeader)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    if fileType == 'markdown':
        with open(fileName, 'a+') as f:
            f.writelines(markdownHeader)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName
    else:
        with open(fileName, 'a+') as f:
            f.writelines(altHeader)
            os.stat(fileName)
            os.chmod(fileName, 0o751)
            return fileName


# function to determine fileExt based on file type passed in
def return_file_ext(fileType):

    if fileType == 'python':
        return '.py'
    if fileType == 'bash':
        return '.sh'
    if fileType == 'rust':
        return '.rs'
    if fileType == 'css':
        return '.css'
    if fileType == 'html':
        return '.html'
    if fileType == 'jss':
        return '.js'
    if fileType == 'yaml':
        return '.yaml'
    if fileType == 'dart':
        return '.dart'
    if fileType == 'md':
        return '.md'


# TODO: <09-01-20, yourname> # make a function to add the header to files also make a function to open newly created
# files in vim or nvim

def return_file_list(srcPath, ignoredFiles):
    import os.path
    import fnmatch

    if ignoredFiles == None:
        ignoredFiles = ''
    else:
        ignored_list = [var for var in ignoredFiles]

    # main body of the program with trees based on output options
    if ignoredFiles == '':
        file_list = [x.strip() for x in os.listdir(srcPath) if os.path.isfile(os.path.join(srcPath, x))]
        return file_list
    else:
        file_list = [x.strip() for x in os.listdir(srcPath) if os.path.isfile(os.path.join(srcPath, x))]
        for item in ignored_list:
            found_list = [x.strip() for x in os.listdir(srcPath) if os.path.isfile(os.path.join(srcPath, x)) and fnmatch.fnmatch(x.lower(), item)]
            file_list = [x for x in file_list if x not in found_list]
        return file_list



# function to determine the file type and how it should be sorted
def separate_file_types(fileName):
    import os.path
    import re
    ebookList = ['.pdf', '.epub', '.djvu', '.pdb', '.ibook', '.azw', '.azw3', '.mobi']
    musicList = ['.mp3', '.flac', '.mpa', '.wav', '.wma', '.ogg']
    videoList = ['.avi', '.flv', '.h264', '.m4v', '.mkv', '.mpg', '.mpeg', '.mov', '.mp4', '.vob', '.wmv']
    picList = ['.ai', '.bmp', '.gif', '.ico', '.jpg', '.jpeg', '.png', '.ps', '.psd', '.svg', '.tif', '.tiff', '.cr2']
    codeList = ['.c', '.class', '.dart', '.py', '.sh', '.rs', '.html', '.css', '.js', '.yaml', '.toml', '.vim',
            '.lua']
    #seperate the baseName and ext from the file and return them to the program 
    baseExt = os.path.splitext(fileName)[-1]
    # make baseExt the regex search
    pattern = re.compile(baseExt)
    # make a switch case statement
    for item in ebookList:
        if re.match(pattern, item):
            return 1
    for item in musicList:
        if re.match(pattern, item):
            return 2
    for item in videoList:
        if re.match(pattern, item):
            return 3
    for item in picList:
        if re.match(pattern, item):
            return 4
    for item in codeList:
        if re.match(pattern, item):
            return 5
    
# function to determine the correct book path based on themes in the title of the ebook
def find_book_paths(fileName):
    import os.path
    import fnmatch
    # create matches for each bookpath search
    pyPattern = '*python*.*'
    vimPattern = '*vim*.*'
    tmuxPattern = '*tmux*.*'
    linuxPattern = '*linux*.*'
    bashPattern = '*bash*.*'
    shellPattern = '*shell*.*'
    rustPattern = '*rust*.*'
    luaPattern = '*lua*.*'
    flutterPattern = '*flutter*.*'
    # Make a Switch Case for titles
    if fnmatch.fnmatch(fileName.lower(), pyPattern):
        return 1
    if fnmatch.fnmatch(fileName.lower(), vimPattern):
        return 2
    if fnmatch.fnmatch(fileName.lower(), tmuxPattern):
        return 3
    if fnmatch.fnmatch(fileName.lower(), rustPattern):
        return 4
    if fnmatch.fnmatch(fileName.lower(), luaPattern):
        return 5
    if fnmatch.fnmatch(fileName.lower(), flutterPattern):
        return 6
    if fnmatch.fnmatch(fileName.lower(), shellPattern):
        return 7
    if fnmatch.fnmatch(fileName.lower(), bashPattern):
        return 7
    if fnmatch.fnmatch(fileName.lower(), linuxPattern):
        return 7
    else:
        return 0


# function to determine the correct destinations based on the filetype
def find_dest_path(fileType, file):
    from os import path

    Home = os.path.expandvars('$HOME')
    compBookDir = os.path.join(Home, 'Documents/ComputerBooks')
    pythonBooks = os.path.join(compBookDir, 'PythonBooks')
    vimBooks = os.path.join(compBookDir, 'VimBooks')
    tmuxBooks = os.path.join(compBookDir, 'TmuxBooks')
    linuxBooks = os.path.join(compBookDir, 'LinuxBooks')
    itBooks = os.path.join(compBookDir, 'ITBooks')
    rustBooks = os.path.join(compBookDir, 'RustBooks')
    luaBooks = os.path.join(compBookDir, 'LuaBooks')
    flutterBooks = os.path.join(compBookDir, 'FlutterBooks')
    # directories for music, videos, books, and code 
    musicDir = os.path.join(Home, 'Music')
    videosDir = os.path.join(Home, 'Videos')
    picsDir = os.path.join(Home, 'Pictures')
    codeDir = os.path.join(Home, 'Code')
    unknownDir = os.path.join(Home, 'OtherShit')

    if fileType == 1:
        bookType = find_book_paths(file)
        if bookType == 1:
            destPath = pythonBooks
            return destPath
        if bookType == 2:
            destPath = vimBooks
            return destPath
        if bookType == 3:
            destPath = tmuxBooks
            return destPath
        if bookType == 4:
            destPath = rustBooks
            return destPath
        if bookType == 5:
            destPath = luaBooks
            return destPath
        if bookType == 6:
            destPath = flutterBooks
            return destPath
        if bookType == 7:
            destPath = linuxBooks
            return destPath
        if bookType == 0:
            destPath = itBooks
            return destPath
    if fileType == 2:
        destPath = musicDir
        return destPath
    if fileType == 3:
        destPath = videosDir
        return destPath
    if fileType == 4:
        destPath = picsDir
        return destPath
    if fileType == 5:
        destPath = codeDir
        return destPath
    else:
        destPath = unknownDir 
        return destPath
                


# function to confirm the destination path, if exists return, if id doesnt exit create it and confirm
def confirm_dest_path(destPath):
    import os.path
    if not os.path.exists(destPath):
        os.mkdir(destPath)
        return 1
    else:
        return 0


# function to move the files from given path and name to new path and name
def move_file(srcPath, destPath, fileName):
    import os.path
    import shutil
    srcPath = srcPath
    destPath = destPath
    if os.path.isfile(fileName):
        if not os.path.exists(os.path.join(destPath, fileName)):
            shutil.move(fileName, destPath)
            return 1
        else:
            os.remove(fileName)
            return 2
    else:
        return 3
    return



# function to open the file in vim or nvim
def open_in_editor(fileName):
    import subprocess
    subprocess.run(['nvim', fileName])


# function to show and confirm destination path
def show_dest_file_list(destPath):
    files = os.listdir(destPath)
    for file in files:
        print(file)
    return
