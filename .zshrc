# vim: set ft=sh:
##############################################################################
#                                  options                                   #
##############################################################################

# to run set up again:
# autoload -U zsh-newuser-install
# zsh-newuser-install -f

bindkey -e
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'
autoload -Uz compinit
compinit

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
    eval 'LBUFFER="$LBUFFER$command "'
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

alias R='start-r'
alias bak='backup-file'
alias dot='wrap-git-dot'
alias focus='play-focus-playlist'
alias sync='sync-repos'
alias install='pacman -S'
alias jot=". ~/scripts/take-notes"
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mvv='rename-files'
alias p='pwd'
alias play='ffplay'
alias pw='cat ~/.passwords/waterboard > /dev/clipboard'
alias remove='pacman -R'
alias search='pacman -Ss'
alias st='cygstart'
alias t='date "+%H:%M"'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias update='pacman -Syu'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias go='go-to-link'
alias timer='set-timer'

#######################################################################
#                                tmux                                 #
#######################################################################

if [ -z "$TMUX" ] 
then
	tmux
fi

