
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

# completion
# The following lines were added by compinstall
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# options and variables
setopt extended_glob
bindkey -e

setopt hist_ignore_dups
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=/usr/bin/vim

date=$(date +'%Y-%m-%d')

# prompt
setopt prompt_subst
source ~/scripts/git-prompt.sh
# Set terminal title
precmd() {
    print -Pn '\e]0;%m\a'
}
PROMPT='
%F{white}%m %~$(__git_ps1 " %s")
%# %f'

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
alias sshxt='ssh -YC jfin@10.0.0.27'
alias suspend='set-wake-and-suspend'
alias wol="powershell -ExecutionPolicy Bypass -File ~/scripts/wake-on-lan.ps1"
alias ls="ls -1F"
alias ll="ls -lh"
alias start='cmd //c start ""'
alias rm='move-to-trash'
alias todo='rg --trim "#todo" ~/notes/notes.txt | sort'

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

# magic abbreviation
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
typeset -Ag abbreviations
abbreviations=(
  "vn"  "> /dev/null 2>&1"
  "vc"  "> /dev/clipboard"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

zle -N magic-abbrev-expand
bindkey " " magic-abbrev-expand

alias -g vn="> /dev/null 2>&1"
alias -g vc="> /dev/clipboard"

# host specific
HOSTNAME=${HOSTNAME:-$HOST}
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

    # use local time, doesn't recognize 'Americal/Los_Angeles'
    export TZ='PST8PDT'
elif [[ $HOSTNAME == rpi ]]; then
elif [[ $HOSTNAME == t14 ]]; then 
fi
