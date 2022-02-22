# vim: set ft=sh:
##############################################################################
#                                  options                                   #
##############################################################################

# to run set up again:
# autoload -U zsh-newuser-install
# zsh-newuser-install -f

bindkey -e
# zstyle ':completion:*' completer _expand _complete _ignored
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
# zstyle :compinstall filename '/home/jfin/.zshrc'
# autoload -Uz compinit
# compinit

setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

##############################################################################
#                                 environment                                #
##############################################################################

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS/\//}

if [ -n "$TMUX" ] 
then
	PS1='%F{red}%(?..:( %?
)%f
%F{#888}tmux %#%f '
else
	PS1='%F{red}%(?..:( %?
)%f
%F{#888}%#%f '
fi
 
##############################################################################
#                                functions                                   #
##############################################################################

function get-command() {
    local command
    echo
    command=$(history -r -n 1 | fzy) 
    eval 'LBUFFER="$command "'
    zle reset-prompt
}
zle -N get-command
bindkey "^r" "get-command"

function get-file() {
    local file
    echo
	file=$(find -path "*/.*" -prune -o -print | fzy)
    eval 'LBUFFER="$LBUFFER$file "'
    zle reset-prompt
}
zle -N get-file
bindkey "^t" "get-file"


##############################################################################
#                                 aliases                                    #
##############################################################################

alias dash='dash -l'
alias R='run-r'
alias bak='make-backup'
alias dot='run-dot-git'
alias dott='sync-dot-repo'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias go='get-link'
alias hours='get-hours'
alias summary='get-summary'
alias install='pacman -S'
alias jot='. ~/scripts/take-notes'
alias todo='jot #todo'
alias kb='get-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mvv='rename-files'
alias pw='cat ~/.passwords/waterboard > /dev/clipboard'
alias remove='pacman -R'
alias search='pacman -Ss'
alias sync='sync-work-repos'
alias t='date "+%H:%M"'
alias timer='set-timer'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias update='pacman -Syu'
alias vlc='/c/Program\ Files/VideoLAN/VLC/vlc.exe'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'

#######################################################################
#                                tmux                                 #
#######################################################################

if [ -z "$TMUX" ] 
then
	tmux
fi
