# vim: set ft=sh:

# zsh options
bindkey -e
setopt sh_word_split
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history
# zstyle :compinstall filename '/home/jfin/.zshrc'
# zstyle ':completion:*' completer _expand _complete _ignored
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
# autoload -Uz compinit
# compinit

# environment
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#prompt
PROMPT="%(?..%F{red}%?%f"$'\n'")"$'\n'"%F{#888}${TMUX:+tmux}%#%f "

# aliases 

alias summary='Rscript ~/scripts/get-summary.r'
alias R='R --quiet --no-save'
alias hours='Rscript ~/scripts/get-hours.r'
alias bak='make-backup'
alias dash='ENV=~/.shinit dash'
alias dot='run-dot-git'
alias dott='sync-dot-repo'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias go='open-link'
alias install='pacman -S'
alias jot='take-notes'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mvv='rename-files'
alias pw='cat ~/.passwords/waterboard > /dev/clipboard'
alias remove='pacman -R'
alias search='pacman -Ss'
alias sync='sync-work-repos'
alias timer='set-timer'
alias todo='take-notes -t'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias update='pacman -Syu'
alias vlc='/c/Program\ Files/VideoLAN/VLC/vlc.exe'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias play='play-files'
alias def='/c/Users/jinman/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup/set-default-apps.bat'

# start tmux
if [ -z "$TMUX" ]; then
    tmux 
fi
