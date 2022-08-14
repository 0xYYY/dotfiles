## Oh My Zsh

export ZSH=$HOME/.oh-my-zsh

# auto-update
zstyle ':omz:update' mode auto

# plugins
# zvm
function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}
plugins=(git tmux extract fd ripgrep rust zoxide yarn)

source $ZSH/oh-my-zsh.sh


## General

# bindkeys
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# environment variables
# export USER=dev
export SHELL=/bin/zsh
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# alias
alias v="nvim"
alias l="exa"
alias la="exa --all"
alias ll="exa --long"
alias lla="exa --long --all"
alias lt="exa --tree --long"
alias lta="exa --tree --long --all"

# fzf
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# _gen_fzf_default_opts() {
#     local base03="#002b36"
#     local base02="#073642"
#     local base01="#586e75"
#     local base00="#657b83"
#     local base0="#839496"
#     local base1="#93a1a1"
#     local base2="#eee8d5"
#     local base3="#fdf6e3"
#     local yellow="#b58900"
#     local orange="#cb4b16"
#     local red="#dc322f"
#     local magenta="#d33682"
#     local violet="#6c71c4"
#     local blue="#268bd2"
#     local cyan="#2aa198"
#     local green="#859900"
# 
#     export FZF_DEFAULT_OPTS="
#     --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
#     --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow 
#     --preview 'bat --color=always --style=numbers --line-range=:500 {}' "
# }
# _gen_fzf_default_opts

# tsc
tsc () {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 SESSION-NAME WORKING-DIRECTORY" >&2
        return 1
    elif [[ -e "$2" && ! -d "$2" ]]; then
        echo "tsc: $2 is not a directory" >&2
        return 2
    else
        mkdir -p $2
        tmux new-session -d -s $1 -c $2
        if [ -z "$TMUX" ]; then
            tmux attach -t $1
        else
            tmux switch -t $1
        fi
    fi
}

# starship
eval "$(starship init zsh)"

# mamba
export MAMBA_EXE="$HOME/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/.micromamba";
__mamba_setup="$($HOME/.local/bin/micromamba shell hook --shell zsh --prefix $HOME/.micromamba 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "$HOME/.micromamba/etc/profile.d/micromamba.sh" ]; then
        . "$HOME/.micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="$HOME/.micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
alias mamba="micromamba"
mamba activate

# volta
export VOLTA_HOME="$HOME/.volta"

# autin
eval "$(atuin init zsh)"

# zvm
zvm_after_init_commands+=("bindkey '^P' up-line-or-search" "bindkey '^N' down-line-or-search")

