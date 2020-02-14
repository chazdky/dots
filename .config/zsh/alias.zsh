#############
#  ALIASES  #
#############

# will be integrated to 'dotfiles.sh'
#compdef dotfiles=git

pfetch

# go to parent
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

# ls variants
alias l='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first' # all files and dirs
alias ll='exa -l --color=always --group-directories-first' # long format
alias lt='exa -aT --color-always --group-directories-first' # tree listing


# suffix aliases
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"


# misc aliases
alias si='sudo -i zsh'
alias :q='exit'
alias bcl='bc -l'
alias t='tail -f'
alias wa='watch -ctn 2'
alias open='xdg-open'
alias grep='grep --color=auto --exclude-dir={.git,.svn,.hg}'
alias egrep='egrep --color=auto --exclude-dir={.git,.svn,.hg}'
alias diff='diff --color=auto'
alias journalctl='journalctl -r'
alias gdb='gdb -q'
alias zaf='zathura --fork'
alias cht='cht.sh'
alias cheat='curl cheat.sh'
alias csh='cht.sh --shell'
alias nvt='nvim ~/.config/nvim/UltiSnips/tex.snippets'

# directory aliases
alias script='cd ~/Documents/Scripts'
alias sproj='cd ~/Documents/SchoolProjects'
alias sdoc='cd ~/Documents/SchoolDocs'
alias pproj='cd ~/Documents/PersonalProjects'
alias sprac='cd ~/Documents/Scripts/PracticeScripts'
alias cfg='cd ~/.config'
alias books='cd ~/Documents/ComputerBooks'
alias notes='cd ~/Notes'
alias ej='cd ~/Notes/EngineeringJournal'
alias ej167='cd ~/Notes/EngineeringJournal/CIT167'
alias ej217='cd ~/Notes/EngineeringJournal/CIT217'
alias ej288='cd ~/Notes/EngineeringJournal/CIT288'
alias us='cd ~/.config/nvim/UltiSnips'

# vim/nvim aliases
alias nv='nvim'
alias gv='glrnvim'
alias gvf='glrnvim'
alias vv='vim'
alias qnv='nvim-qt'

# git aliases
alias gis='git status'
alias gic='git commit'
alias gini='git init'
alias gipus='git push'
alias gitpl='git pull'
alias gst='git stash'
alias gra='git remote add origin'
alias gpm='git push -u origin master'

# Tmux aliases
alias tas='tmux attach session'
alias tds='tmux detach session'
alias tls='tmux list session'
alias tks='tmux kill session'

# Termdown aliases
alias td5m='termdown -b 5m'
alias tdtm='termdown -b 20m'
alias tdfm='termdown -b 15m'

# Utility aliases
alias nf='neofetch'
alias clock='tty-clock'
alias cconv='color-converter'
alias yaycache='yay -Sc --aur'
alias paccache='yay -Sc'
alias vnva='source .venv/bin/activate'
alias lxc='latexclean'
alias vitunes='vivaldi-stable https://beta.music.apple.com/for-you --fork --new-window'

# set aliases for sourcing files
alias soz='source ~/.zshrc'
alias soa='source ~/.config/awesome/rc.lua'
alias sok='source ~/.config/kitty/kitty.conf'
alias zalias='nv ~/.config/zsh/alias.zsh'

# tty aliases
if [[ "$TERM" == 'linux' ]]; then
    alias tmux='/usr/bin/tmux -L linux'
fi

# bring job to fg
foreground-job() {
    fg
}
zle     -N   foreground-job
bindkey '^Z' foreground-job

# mkdir + cd
mkcd() {
    [[ $# -gt 1 ]] && return 1
    mkdir -p "$1" && cd "$1" || return 1
}

# cd + ls
cdl() {
   cd "$1"; ls -al $CWD
}

# list directories and number of files within them
# TODO need to take cwd and then make dict with key ls -al and values wc-l
# archive compress
compress() {
    if [[ -n "$1" ]]; then
        local file=$1
        shift
        case "$file" in
            *.tar ) tar cf "$file" "$*" ;;
            *.tar.bz2 ) tar cjf "$file" "$*" ;;
            *.tar.gz ) tar czf "$file" "$*" ;;
            *.tgz ) tar czf "$file" "$*" ;;
            *.zip ) zip "$file" "$*" ;;
            *.rar ) rar "$file" "$*" ;;
            * ) tar zcvf "$file.tar.gz" "$*" ;;
        esac
    else
        echo 'usage: compress <foo.tar.gz> ./foo ./bar'
    fi
}

# archive extract
extract() {
    if [[ -f "$1" ]] ; then
        local filename=$(basename "$1")
        local foldername=${filename%%.*}
        local fullpath=$(perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1")
        local didfolderexist=false
        if [[ -d "$foldername" ]]; then
            didfolderexist=true
            read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
            echo
            if [[ "$REPLY" =~ ^[Nn]$ ]]; then
                return
            fi
        fi
        mkdir -p "$foldername" && cd "$foldername"
        case "$1" in
            *.tar.bz2) tar xjf "$fullpath" ;;
            *.tar.gz) tar xzf "$fullpath" ;;
            *.tar.xz) tar Jxvf "$fullpath" ;;
            *.tar.Z) tar xzf "$fullpath" ;;
            *.tar) tar xf "$fullpath" ;;
            *.taz) tar xzf "$fullpath" ;;
            *.tb2) tar xjf "$fullpath" ;;
            *.tbz) tar xjf "$fullpath" ;;
            *.tbz2) tar xjf "$fullpath" ;;
            *.tgz) tar xzf "$fullpath" ;;
            *.txz) tar Jxvf "$fullpath" ;;
            *.zip) unzip "$fullpath" ;;
            *) echo "'$1' cannot be extracted via extract()" \
                && cd .. \
                && ! "$didfolderexist" \
                && rm -r "$foldername" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# tre is a shorthand for tree
tre() {
    tree -aC -I \
        '.git|.hg|.svn|.tmux|.backup|.vim-backup|.swap|.vim-swap|.undo|.vim-undo|*.bak|tags' \
        --dirsfirst "$@" \
        | less
 }

# shorthand for python debug mode
p3db() {
   python3 -m pdb "$1"
}

# shorthand for python traceroute
ptrace() {
   python3 -m trace --trace "$1"
}
# switch from/to project/package dir
pkg() {
    if [ "$#" -eq 2 ]; then
        ln -s "$(readlink -f $1)" "$(readlink -f $2)"/._pkg
        ln -s "$(readlink -f $2)" "$(readlink -f $1)"/._pkg
    else
        cd "$(readlink -f ./._pkg)"
    fi
 }

bak() {
   if [[ -e "$1" ]]; then
       echo "Found: $1"
       mv "${1%.*}"{,.bak}
   elif [[ -e "$1.bak" ]]; then
       echo "Found: $1.bak"
       mv "$1"{.bak,}
   fi
}

lsp-prep() {
   (cd build && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON) \
       && ln -sf build/compile_commands.json
   }

toggle() {
   kitty @ set-colors --configured --all ~/.config/kitty/gruvbox-light.conf
   source ~/.config/zsh/custom/themes/gruvbox-light.zsh-theme
}


#################
#  KEYBINDINGS  #
#################

# ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

# alt+arrows
bindkey "\e[1;3C" vi-forward-blank-word
bindkey "\e[1;3D" vi-backward-blank-word
bindkey "\e[3C" vi-forward-blank-word
bindkey "\e[3D" vi-backward-blank-word
bindkey "\e\e[C" vi-forward-blank-word
bindkey "\e\e[D" vi-backward-blank-word

# ctrl+delete
bindkey "\e[3;5~" kill-word
bindkey "\e[3;3~" kill-word

# ctrl+backspace
bindkey '^H' backward-kill-word

# ctrl+shift+delete
bindkey "\e[3;6~" kill-line


#########
#  FZF  #
#########

# alias fzf="fzf-tmux -d 30% --"


#############
#  RIPGREP  #
#############

# fuzzy rg
frg() {
    rg --line-number \
        --column \
        --no-heading \
        --color=always \
        --colors='match:none' \
        --colors='path:fg:white' \
        --colors='line:fg:white' \
        "$@" . 2> /dev/null \
        | fzf --ansi
}


#########################
# THE PLATINUM SEARCHER #
#########################

alias ag="pt \
    --hidden \
    --follow \
    --smart-case \
    --numbers \
    --color-match '1;31' \
    --color-path '0;37' \
    --color-line-number '1;33'"

# fuzzy ag
fag() {
    pt --after=0 \
       --before=0 \
        --nogroup \
        --color \
        --color-match '' \
        --color-path '0;37' \
        --color-line-number '0;37' \
        "$@" . 2> /dev/null \
        | fzf --ansi
}


##################
# FUZZY COMMANDS #
##################

# cd to selected directory
c() {
    cd "$(fd -td -HLI --print0 '.' "${1:-.}" 2> /dev/null \
        | fzf +s +m +e --read0 -0)" \
        || return 1
}

# cd to selected directory and open ranger
r() {
    c "$@" && ranger
}

# open the selected file with the default editor
#       - CTRL-O to open with `open` command,
#       - CTRL-E or Enter key to open with the $EDITOR
fo() {
    local out file key
    IFS=$'\n' out=($(fzf +s +m +e -q "$1" -0 --expect=ctrl-o,ctrl-e))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] \
            && mimeopen -n "$file" \
            || "${EDITOR:-nvim}" "$file"
    fi
}

# cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf +s +m +e -q "$1" -0) \
        && dir=$(dirname "$file") \
        && cd "$dir" \
        || return 1
}

# browse chrome history
# ch() {
#    local cols sep google_history open
#    cols=$(( COLUMNS / 3 ))
#    sep='{::}'

#    if [ "$(uname)" = "Darwin" ]; then
#        google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
#        open="open"
#    else
#        google_history="$HOME/.config/chromium/Default/History"
#        open="mimeopen -n"
#    fi

#    cp -f "$google_history" /tmp/h
#    sqlite3 -separator "$sep" /tmp/h \
#        "select substr(title, 1, $cols), url
#    from urls order by last_visit_time desc" \
#        | awk -F "$sep" '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' \
#        | fzf --ansi -m \
#        | sed 's#.*\(https*://\)#\1#' \
#        | xargs "$open" > /dev/null 2> /dev/null
#}

# cd to selected parent directory
fdp() {
    local dirs=()

    get_parent_dirs() {
        if [[ -d "$1" ]]; then
            dirs+=("$1"); else return;
        fi
        if [[ "$1" == '/' ]]; then
            for d in "${dirs[@]}"; do
                echo "$d";
            done
        else
            get_parent_dirs "$(dirname "$1")"
        fi
    }

    cd "$(get_parent_dirs "$(realpath "${1:-$PWD}")" | fzf --tac)" \
        || return 1
}

# kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo "$pid" | xargs kill -"${1:-9}"
    fi
}

# pacman search
# example usage: pacman -S $(fp)
fp() {
    echo -n "$(pacman --color always "${@:--Ss}" \
        | sed 'N;s/\n//' \
        | fzf -m --ansi \
        | sed 's/ .*//')"
}

# man search
fman() {
    man "$(apropos . | fzf | sed 's/ .*//')"
}


#############
#  WIDGETS  #
#############

# command search (formatted like official fzf keybindings)
fzf-command-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(rofi_path |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n "$num"
        fi
    fi
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return "$ret"
}
zle     -N    fzf-command-widget
bindkey '\e-' fzf-command-widget
bindkey '\e.' fzf-command-widget

# cd into the selected directory
zle     -N    fzf-cd-widget
bindkey '\eg' fzf-cd-widget

# cd to parent
cd-parent-widget() {
    echo
    cd ..
    zle reset-prompt
}
zle     -N   cd-parent-widget
bindkey '^n' cd-parent-widget

# cd to home
cd-home-widget() {
    echo
    cd
    zle reset-prompt
}
zle     -N    cd-home-widget
bindkey '\en' cd-home-widget

# open ranger
ranger-widget() {
    ranger < "$TTY"
    zle reset-prompt
}
zle     -N    ranger-widget
bindkey '\eo' ranger-widget

# open ranger, cd to chosen directory
ranger-cd-widget() {
    echo
    trap 'rm -f /tmp/.rangerdir' SIGINT SIGTERM EXIT
    ranger --choosedir="/tmp/.rangerdir" < "$TTY"
    cd $(< "/tmp/.rangerdir")
    zle reset-prompt
}
zle     -N     ranger-cd-widget
bindkey '\e^o' ranger-cd-widget
