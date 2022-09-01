## Oh My Zsh

export ZSH=$HOME/.oh-my-zsh

# auto-update
zstyle ':omz:update' mode auto

# zvm
function zvm_config() {
    ZVM_VI_ESCAPE_BINDKEY=jk
    ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
    ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
}
zvm_after_init_commands+=("bindkey '^P' up-line-or-search" "bindkey '^N' down-line-or-search" "bindkey '^r' _atuin_search_widget")

# plugins
plugins=(extract fd git golang tmux ripgrep rust yarn zoxide zsh-vi-mode)
FOUNDRY_PLUGIN_DIR=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/foundry
fpath+=$FOUNDRY_PLUGIN_DIR

source $ZSH/oh-my-zsh.sh


## General

# environment variables
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
alias rip="rip --graveyard ~/.local/share/graveyard"
alias ipy="ipython"

FOUNDRY_BUILD_DIR=$HOME/repos/foundry/target/debug
alias lanvil=$FOUNDRY_BUILD_DIR/anvil
alias lcast=$FOUNDRY_BUILD_DIR/cast
alias lforge=$FOUNDRY_BUILD_DIR/forge

# tmux
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

# direnv
eval "$(direnv hook zsh)"

# atuin
eval "$(atuin init zsh)"
# atuin import auto

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

# sort the exported mamba environment file, for better git diff
mambaenv () {
    local ENV_FILE=${1:-"./environment.yml"}

    mamba env export > $ENV_FILE
    cutoff=$(rg -n dependencies $ENV_FILE | choose -f ':' 0)

    tmpfile=$(mktemp /tmp/mamba-env.XXXXXX)
    head -n $cutoff $ENV_FILE >>$tmpfile
    tail -n +$((cutoff + 1)) $ENV_FILE | sort >>$tmpfile

    mv $tmpfile $ENV_FILE
}

# volta
export VOLTA_HOME="$HOME/.volta"

# goenv
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# foundry
fup () {
    if ! command -v foundryup &> /dev/null; then
        echo "Install foundryup first: https://getfoundry.sh"
    else
        foundryup "$@"
        mkdir -p $FOUNDRY_PLUGIN_DIR
        anvil com zsh > $FOUNDRY_PLUGIN_DIR/_anvil
        cast com zsh > $FOUNDRY_PLUGIN_DIR/_cast
        forge com zsh > $FOUNDRY_PLUGIN_DIR/_forge
    fi
}
