# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chazdii/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/chazdii/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/chazdii/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/chazdii/.fzf/shell/key-bindings.zsh"
