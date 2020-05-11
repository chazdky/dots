export TEXMFHOME='/opt/texlive/texmf-local'
export ZIM_HOME='/usr/lib/zim'
# set nvim to open in running instance. if no running instance
# it will open a new instance
if [[ -n "$NVIM_LISTEN_ADDRESS" && -f "HOME/.local/bin/nvr" ]]; then
    export VISUAL="nvr --servername 127.0.0.1:1615 $@"
else
    export VISUAL="nvim"
fi

export EDITOR=$VISUAL

export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'
export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ANDROID_HOME=$HOME/Android
export ANDROID_SDK=$HOME/Android/
export ANDROID_SDK_ROOT=$HOME/Android/
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/emulator
export ZSH_CUSTOM="$ZSH_CONFIG/custom"
