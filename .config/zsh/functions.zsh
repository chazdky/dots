# Test whether a given command exists
# Adapted from http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script/3931779#3931779
# NOTE: This function is duplicated in .zshrc so that it doesn't have to depend on this file,
# but this shouldn't cause any issues
function command_exists() {
  hash "$1" &> /dev/null
}

# Show a cheatsheet from https://cht.sh
function cheat() {
  curl "https://cht.sh/$1"
}

# Found at <http://www.askapache.com/linux/zen-terminal-escape-codes.html#3rd_Dimension_Broken_Bash>
function colortest() {
  x=`tput op` y=`printf %$((${COLUMNS}-6))s`
  for i in {0..256}
  do
    o=00$i
    echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x
  done
}

# Packs $2-$n into $1 depending on $1's extension
# Found at <http://pastebin.com/CTra4QTF>
function compress() {
  if [[ $# -lt 2 ]]; then
    echo -e "\n$0() usage:"
    echo -e "\t$0 archive_file_name file1 file2 ... fileN"
    echo -e "\tcreates archive of files 1-N\n"
  else
    DEST=$1
    shift
    case $DEST in
      *.tar.bz2) tar -cvjf $DEST "$@" ;;
      *.tar.gz)  tar -cvzf $DEST "$@" ;;
      *.zip)     zip -r $DEST "$@" ;;
      *)         echo "Unknown file type - $DEST" ;;
    esac
  fi
}

# Retrieve dictionary definitions of words.
# Adapted from code found at <http://onethingwell.org/post/25644890287/a-shell-function-to-define-words>
function define() {
  if [[ $# -ge 2 ]]; then
    echo "$0: too many arguments" >&2
    return 1
  else
    curl "dict://dict.org/d:$1"
  fi
}

# Extracts archives
# Found at <http://pastebin.com/CTra4QTF>
function extract() {
  case $@ in
    *.tar.bz2) tar -xvjf "$@"  ;;
    *.tar.gz)  tar -xvzf "$@"  ;;
    *.bz2)     bunzip2 "$@"  ;;
    *.rar)     unrar x "$@"  ;;
    *.gz)      gunzip "$@" ;;
    *.tar)     tar xf "$@" ;;
    *.tbz2)    tar -xvjf "$@"  ;;
    *.tgz)     tar -xvzf "$@"  ;;
    *.zip)     unzip "$@"    ;;
    *.xpi)     unzip "$@"    ;;
    *.Z)       uncompress "$@" ;;
    *.7z)      7z x "$@" ;;
    *.ace)     unace e "$@"  ;;
    *.arj)     arj -y e "$@" ;;
    *)         echo "'$@' cannot be extracted via $0()" ;;
  esac
}

# Visual Studio Code-enabled replacement for `gdt` alias.
function gdt() {
  # If running inside Visual Studio Code, use it if diffing a single file (it doesn't support directory diffs.)
  if [ "$#" -eq 1 ] && [ -f "$1" ] && [ "$TERM_PROGRAM" == "vscode" ]; then
    git difftool --tool vscode "$@"
  else
    git difftool -d "$@"
  fi
}

# "Smart show" for Git. Show what I most likely want to see at any given time.
function gss() {
  git status &> /dev/null
  inside_git_repo=$?
  if [[ $inside_git_repo -eq 0 ]]; then

    git diff --quiet
    has_unstaged_changes=$?

    git diff --quiet --cached
    has_staged_changes=$?

    if [[ $has_unstaged_changes -eq 1 ]]; then
      echo "Showing diff of unstaged changes..."
      git difftool -d
    elif [[ $has_staged_changes -eq 1 ]]; then
      echo "Showing diff of staged changes..."
      git difftool -d --staged
    else
      echo "Showing last commit..."
      git difftool -d HEAD~1 HEAD
    fi

  else
    echo "Error: \"$0\" can only be used inside a Git repository."
  fi
}

# Search shell history
function hgrep() {
  history 1 | grep $1
}

# Convert a web page to Markdown.
function md() {
  if [[ $# -ne 1 ]]; then
    echo -e "\n$0() usage:"
    echo -e "\t$0 [URL]"
    return 1
  fi
  echo "[Source]($1)\n"
  wget -qO - "$1" | iconv -t utf-8 | html2text -b 0
}

# function md() {
#   if  command_exists html2text; then
#     echo "Error: html2text must be installed (via \"pip install html2text\") in order to use $0."
#     return 1
#   fi
#   if [[ $# -ne 1 ]]; then
#     echo -e "\n$0() usage:"
#     echo -e "\t$0 [URL]"
#     return 1
#   fi
#   echo "[Source]($1)\n"
#   wget -qO - "$1" | iconv -t utf-8 | html2text -b 0
# }

# Calculate a hash of all files in the current directory.
# Adapted from code found at <http://stackoverflow.com/a/1658554/278810>
function md5dir() {
	if command_exists gmd5sum; then
		md5Command='gmd5sum' # Mac (coreutils via Homebrew)
	elif command_exists md5; then
		md5Command='md5 -q' # Mac (native)
	elif command_exists md5sum; then
		md5Command='md5sum' # Linux
	else
		echo "Error: No md5 program available!"
		return 1
	fi
	eval "find . -type f -exec $md5Command {} + | cut -d ' ' -f 1 | sort | $md5Command | cut -d ' ' -f 1"
}

function mirror() {
  wget -H -r --level=1 -k -p $1
}

# Shows how long processes have been up.
# No arguments shows all processes, one argument greps for a particular process.
# Found at <http://hints.macworld.com/article.php?story=20121127064752309>
function psup() {
  ps acxo etime,command | grep -- "$1"
}

# Pushes local SSH public key to another box
# Adapted from code found at <https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc>
function push_ssh_cert() {
  if [[ $# -eq 0 || $# -gt 3 ]]; then
    echo "Usage: push_ssh_cert host [port] [username]"
    return
  fi
  local _host=$1
  local _port=22
  local _user=$USER
  if [[ $# -ge 2 ]]; then
    _port=$2
  fi
  if [[ $# -eq 3 ]]; then
    _user=$3
  fi
  test -f ~/.ssh/id_*sa.pub || ssh-keygen -t rsa
  echo "Pushing public key to $_user@$_host:$_port..."
  ssh -p $_port $_user@$_host 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_*sa.pub
}

# Find and replace a string in all files recursively, starting from the current directory.
# Adapted from code found at <http://forums.devshed.com/unix-help-35/unix-find-and-replace-text-within-all-files-within-a-146179.html>
function replacein() {
  find . -type f | xargs perl -pi -e "s/$1/$2/g"
}

# Search for files by name
# Case-insensitive and allows partial search
# If on Mac OS X, will prompt to open the file if there is a single result
function search() {
  results=`find . -iname "*$1*"`
  echo $results
  if command_exists open; then
    resultLength=`echo $results | wc -l | sed -e "s/^[ \t]*//"`
    if [ $resultLength -eq 1 ]; then
      while true; do
        echo "One result found! Open it? (y/n)?"
        read yn
        case $yn in
          [Yy]* ) open $results; break;;
          [Nn]* ) break;;
          * ) echo "Please answer (Y/y)es or (N/n)o.";;
        esac
      done
    fi
  fi
}

# To search for a given string inside every file with the given filename
# (wildcards allowed) in the current directory, recursively:
#   $ searchin filename pattern
#
# To search for a given string inside every file inside the current directory, recursively:
#   $ searchin pattern
function searchin() {
  if [ -n "$2" ]; then
    find . -name "$1" -type f -exec grep -l "$2" {} \;
  else
    find . -type f -exec grep -l "$1" {} \;
  fi
}

# Serves the current directory over HTTP, on an optionally-specified port
# If on Mac OS X, opens in the default browser
function serve() {
  port=$1
  if [ $# -ne  1 ]; then
    port=8000
  fi
  if command_exists open; then
    open http://localhost:$port/
  fi
  python -m SimpleHTTPServer $port
}


# Copy dotfiles to one or more remote machines.
function sync_home() {
  local DOTFILES_LOCATION="${$(readlink ~/.zshrc)%/*.*}"
  if [ -z "$DOTFILES_LOCATION" ] || [ "$DOTFILES_LOCATION" = "$HOME" ]; then
    echo "$0 can only operate from inside a self-contained dotfiles repository."
    echo "It's likely that $0 was used to sync dotfiles to this machine."
    echo "Exiting."
    return 1
  fi

  test -z "$1" || echo "$@" | grep -q -- '--help' && {
    echo "Usage: $0 [user@]host ..."
    return 1
  }

  for host in "$@"; do
    echo "Now syncing: $host"
    # Find all files/directories at the root level of $HOME that are symlinked into $DOTFILES_LOCATION
    sync_list=(`find "$HOME" -maxdepth 1 -type l -lname "$DOTFILES_LOCATION*"`)
    rsync -avzL "${sync_list[@]}" "${host}:"
  done
}

# Updates stuff!
# * Performs a system update on Debian-based and Arch Linux systems
# * Updates all dotfiles Git submodules (including Vim packages)
# * Updates Homebrew packages on OS X
# * Updates pip/gem/npm/cargo
function update() {
  heading() { echo -e "\e[1m\e[34m==>\e[39m $1\e[0m" }

  if command_exists apt-get; then
    heading "[apt-get] Updating system packages..."
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get clean
    sudo apt-get autoremove
  elif command_exists pacman; then
    heading "[pacman] Updating system packages..."
    sudo pacman -Syu
    sudo pacman -Scc
    heading "[yay] Updating User Repo Packages..."
    yay -Syu
    yay -Scc --aur
  elif command_exists brew; then
    heading "[homebrew] Updating system packages..."
    brew update && brew upgrade && brew cleanup
  fi

  # If the dotfiles location isn't the home directory,
  # assume it's a Git repository and update it and all submodules.
  local DOTFILES_LOCATION="${$(readlink ~/.zshrc)%/*.*}"
  if [ ! -z "$DOTFILES_LOCATION" ] && [ "$DOTFILES_LOCATION" != "$HOME" ] && command_exists git; then
    heading "[git] Updating dotfiles..."
  # Run in a subshell so the user's working directory doesn't change
    (cd "$DOTFILES_LOCATION" && git pull && git submodule update --recursive --checkout --remote --init)
  fi

  # Since Vim packages may have been updated, update Vim helptags.
  heading "[vim] Updating Vim helptags..."
  vim '+helptags ALL' +qall

  if command_exists yarn; then
    heading "[coc] Updating coc.nvim and associated extensions..."
    ls -d ~/.vim/pack/plugins/opt/coc* | xargs -L 1 zsh -c 'cd "$0" && yarn install --frozen-lockfile'
  fi

  if command_exists npm; then
    heading "[npm] Updating global packages..."
    npm -g update
  fi

  if command_exists cargo; then
    heading "[cargo] Updating global packages..."
    cargo install-update -a
  fi

  if command_exists pip; then
    pip_location="$(which pip)"
    # Only attempt to update `pip` packages if uisng a non-system `pip`.
    if test "${pip_location#*/home/}" != "$pip_location"; then
      heading "[pip] Updating global packages..."
      # Inline Python script to update packages. Found at <http://stackoverflow.com/a/5839291/278810>
      # Assume we have pip >= 10.0.1.
python << END
import pkg_resources
from subprocess import call

packages = [dist.project_name for dist in pkg_resources.working_set]
call("pip install --upgrade " + ' '.join(packages), shell=True)
END
    fi
  fi

  if command_exists gem; then
    gem_location="$(which gem)"
    # Only attempt to update `gem` packages if uisng a non-system `gem`.
    if test "${gem_location#*/home/}" != "$gem_location"; then
      heading "[gem] Updating global packages..."
      gem update
    fi
  fi
}

