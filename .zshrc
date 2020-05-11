#: Debug
#zmodload zsh/zprof

##########################################################################################

###########
#  ZSHRC  #
###########

VISUAL=nvim 
export VISUAL
EDITOR=nvim 
export EDITOR
export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH="$HOME/.oh-my-zsh"
export ANDROID_HOME=$HOME/Android
export ANDROID_SDK=$HOME/Android/
export ANDROID_SDK_ROOT=$HOME/Android/
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/emulator
export ZSH_CUSTOM="$ZSH_CONFIG/custom"
export PYTHONSTARTUP=~/.config/.pyrc
export PIPENV_VENV_IN_PROJECT=1

if [[ "$TERM" != 'linux' ]]; then
    ZSH_THEME='${ZSH_CONFIG}/custom/shades-of-purple'
fi

# setup texlive for use
year=2020
[ -d /opt/texlive/${_year}/bin/x86_64-linux ] && export PATH=$PATH:/opt/texlive/${_year}/bin/x86_64-linux
[ -d /opt/texlive/${_year}/texmf-dist/doc/man ] && export MANPATH=:$MANPATH:/opt/texlive/${_year}/texmf-dist/doc/man
[ -d /opt/texlive/${_year}/texmf-dist/doc/info ] && export INFOPATH=:$MANPATH:/opt/texlive/${_year}/texmf-dist/doc/info

#CASE_SENSITIVE="true"
#HYPHEN_INSENSITIVE="true"
#DISABLE_AUTO_UPDATE="true"
#UPDATE_ZSH_DAYS=7
#DISABLE_LS_COLORS="true"
#DISABLE_AUTO_TITLE="true"
#ENABLE_CORRECTION="true"
#COMPLETION_WAITING_DOTS="true"
#DISABLE_UNTRACKED_FILES_DIRTY="true"
#HIST_STAMPS="yyyy-mm-dd"


#############
#  PROFILE  #
#############

[[ -f "$HOME/.zprofile" ]] \
    && source "$HOME/.zprofile"

[[ -f "$HOME/.zshenv" ]] \
    && source "$HOME/.zshenv"

###############
#  DIRCOLORS  #
###############

# eval dircolors
[[ -f "$HOME/.dircolors" ]] \
    && eval "$(dircolors "$HOME/.dircolors")"

# tmuxp completion on the command line
eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"

# fasd to rank and keep track of directories
eval "$(fasd --init auto)"

#####################
#  PLUGIN SETTINGS  #
#####################

# bgnotify settings
bgnotify_threshold=2    ## set your own notification threshold
bgnotify_formatted() {
    ## $1=exit_status, $2=command, $3=elapsed_time
    [[ $1 -eq 0 ]] && title="Zsh" || title="Zsh (fail)"
    bgnotify "$title (${3}s)" "$2"
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    bgnotify
    colorize
    sudo
)

# # Native plugins
# plugins=(
#     command-not-found
#     bgnotify
# )
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Remove plugins if in tty
[[ "$TERM" = 'linux' ]] \
    && plugins=("${(@)plugins:#zsh-autosuggestions}")

# Completions
[[ -f "$ZSH_CONFIG/completion.zsh" ]] \
    && source "$ZSH_CONFIG/completion.zsh"

# Prompt
[[ -f "$ZSH_CONFIG/prompt.zsh" ]] \
    && source "$ZSH_CONFIG/prompt.zsh"

# Alias
[[ -f "$ZSH_CONFIG/alias.zsh" ]] \
    && source "$ZSH_CONFIG/alias.zsh"

# Functions
[[ -f "$ZSH_CONFIG/functions.zsh" ]] \
    && source "$ZSH_CONFIG/functions.zsh"

########################
#  USER CONFIGURATION  #
########################

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

########################
#  Edit CLI With Vim   #
########################
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

############
#  CUSTOM  #
############

# Zsh options
setopt COMPLETE_ALIASES
setopt HIST_IGNORE_SPACE
setopt AUTO_CD
setopt AUTO_PUSHD
setopt AUTO_LIST
setopt APPEND_HISTORY
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

# No scrolllock
stty -ixon

# Highlighting
[[ -f "$ZSH_CONFIG/highlight.zsh" ]] \
    && source "$ZSH_CONFIG/highlight.zsh"

# FZF
[[ -f "$ZSH_CONFIG/fzf.zsh" ]] \
    && source "$ZSH_CONFIG/fzf.zsh"

# Vim mode
#[[ -f "$ZSH_CONFIG/vim.zsh" ]] \
#    && source "$ZSH_CONFIG/vim.zsh"


# TMUX
local main_attached="$(tmux list-sessions -F '#S #{session_attached}' \
    2>/dev/null \
    | sed -n 's/^main[[:space:]]//p')"
if [[ "$main_attached" -le '0' ]] && [[ "$TERM" != 'linux' ]]; then
    tmux new -A -s main -t main >/dev/null 2>&1
    exit
fi

if [[ -n $TMUX ]]; then
    export NVIM_LISTEN_ADDRESS=/tmp/nvim_$USER_`tmux display -p "#{session_attached}"`
fi

function nv() {
  if [ ! -z "$TMUX" ]; then
    local ids="$(tmux list-panes -a -F '#{pane_current_command} #{window_id} #{pane_id}' | awk '/^nvim / {print $2" "$3; exit}')"
    local window_id="$ids[(w)1]"
    local pane_id="$ids[(w)2]"
    [ ! -z "$pane_id" ] && tmux select-window -t "$window_id" && tmux select-pane -t "$pane_id"
  fi
  nvr -s $@
}

# Alternative prompt
if [[ "$TERM" == "linux" ]] || [[ ! -d "$ZSH_CONFIG" ]]; then
    PROMPT='[%F{167}%B%n%b%f@%M %~]'
    PROMPT+='$(git_prompt_info)'
    PROMPT+=' %(?.%F{108}.%F{167})%B%(!.#.$)%b%f '
    ZSH_THEME_GIT_PROMPT_PREFIX=" [%F{214}%B"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f]"
    ZSH_THEME_GIT_PROMPT_DIRTY="%F{167}%B*%b%f"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
fi

# Empty line
function echo_blank() {
    echo
}
precmd_functions+=echo_blank
preexec_functions+=echo_blank

# Directly source prompt
#source "$ZSH_CUSTOM/themes/gruvbox-dark.zsh-theme"

# Kitty completion
source <(kitty + complete setup zsh)

##########################################################################################

# Debug
#zprof
# alias config='/usr/bin/git --git-dir=/home/chazdii/.dotfiles/ --work-tree=/home/chazdii'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/root/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias config='/usr/bin/git --git-dir=/home/chazdii/.cfg/ --work-tree=/home/chazdii'
