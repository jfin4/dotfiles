# completion

# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# options and variables
bindkey -e

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=/usr/bin/vim

date=$(date +'%Y-%m-%d')

# prompt
setopt prompt_subst
source ~/scripts/git-prompt.sh
# PROMPT='
# %F{white}%m %~$(__git_ps1 " %s")
# %# %f'
PROMPT='
%m %~$(__git_ps1 " %s")
%# '
# Set terminal title
precmd() {
    print -Pn "\e]0;%m\a"
}

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$PATH:$HOME/scripts" 
PATH="$PATH:$HOME/.local/bin" 
export PATH

# aliases
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotp='dot pull'
alias dots='dot status'
alias gitp='git pull'
alias gits='git status'
alias soz='source ~/.zshrc'
alias sshr='ssh -p 2222 jfin@10.0.0.160'
alias ssht='ssh jfin@10.0.0.27'
alias suspend='set-wake-and-suspend'
alias wol="powershell -ExecutionPolicy Bypass -File ~/scripts/wake-on-lan.ps1"
alias ls="ls -1F"
alias ll="ls -lh"
alias start='cmd //c start ""'

# functions
dott() { 
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME add -u
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME commit -m "${*:-no message}"
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME push
}

gitt() { 
    git add .
    git commit -m "${*:-no message}"
    git push
}

# host specific
HOSTNAME=${HOSTNAME:+$HOST}
if [[ $HOSTNAME == 'WB-102575' ]]; then
    # shh 
    eval $(ssh-agent -s) > /dev/null 
    ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1

    # path
    PATH="$PATH:$HOME/AppData/Roaming/Python/Python312/Scripts"
    # get latest r
    for r in "c:/Program Files/R"/*; do
        true
    done
    PATH="$PATH:/c${r#c:}/bin/x64" 
    export PATH
elif [[ $HOSTNAME == rpi ]]; then
elif [[ $HOSTNAME == t14 ]]; then 
fi
