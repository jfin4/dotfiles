# vim: set ft=sh:

# zsh options
bindkey -e
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# zsh functions 
get-command () {
    local command
    echo
    command=$(history -r -n 1 | fzy) 
    eval 'LBUFFER="$command "'
    zle reset-prompt
}
zle -N get-command
bindkey "^r" "get-command"

get-file () {
    local file
    echo
    file=$(find -path "*/.*" -prune -o -print | fzy)
    eval 'LBUFFER="$LBUFFER$file "'
    zle reset-prompt
}
zle -N get-file
bindkey "^t" "get-file"

# environment
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#prompt
if [ -n "$TMUX" ]
then
    PS1=$(echo -e "\n[1;30mtmux$ [0m")
else
    PS1=$(echo -e "\n[1;30m$ [0m")
fi

# aliases 
alias R='run-r'
alias bak='make-backup'
alias dash='ENV= dash'
alias dot='run-dot-git'
alias dott='sync-dot-repo'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias go='get-link'
alias hours='get-hours'
alias install='pacman -S'
alias jot='. ~/scripts/take-notes'
alias kb='get-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mvv='rename-files'
alias pw='cat ~/.passwords/waterboard > /dev/clipboard'
alias remove='pacman -R'
alias search='pacman -Ss'
alias summary='get-summary'
alias sync='sync-work-repos'
alias t='date "+%H:%M"'
alias timer='set-timer'
alias todo='jot #todo'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias update='pacman -Syu'
alias vlc='/c/Program\ Files/VideoLAN/VLC/vlc.exe'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'

# start tmux
if [ -z "$TMUX" ] 
then
	tmux
fi

# cruft
# to run set up again:
# autoload -U zsh-newuser-install
# zsh-newuser-install -f
# zstyle ':completion:*' completer _expand _complete _ignored
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
# zstyle :compinstall filename '/home/jfin/.zshrc'
# autoload -Uz compinit
# compinit
