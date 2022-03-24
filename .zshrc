# vim: set ft=sh:

# options
bindkey -e
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'
autoload -Uz compinit
compinit

setopt sh_word_split
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# environment

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#prompt
PROMPT="%(?..%F{red}%?%f"$'\n'")"$'\n'"%F{#888}${TMUX:+tmux}%#%f "
 

# aliases

alias R='start-r'
alias alarm='set-alarm'
alias bak='backup-file'
alias bt='connect-bluetooth'
alias cal='show-calendar'
alias deorphan='sudo pacman -Qtdq | sudo pacman -Rns -'
alias dot='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dott='sync-dot-repo'
alias fd='wrap-find'
alias ff='fuzzy-find-file'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias gittt='sync-all-repos'
alias install='sudo pacman -S'
alias jot='take-notes'
alias kb='get-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lynx="lynx -cfg=$HOME/.lynx/lynx.cfg -lss=$HOME/.lynx/lynx.lss"
alias mcam='sudo mount /dev/disk/by-label/camera /mnt/camera/'
alias mnas='sshfs rp:/mnt /mnt/nas'
alias mobile='connect-mobile'
alias mthumb='sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
alias mutt='cd ~/downloads/ && mutt && cd'
alias mvv='rename-files'
alias mv='mv --no-clobber'
alias off='turn-off-screen'
alias p='pwd'
alias pad='toggle-numpad'
alias mpv='mpv --save-position-on-quit'
alias reboot='sudo reboot'
alias remove='sudo pacman -R'
alias search='sudo pacman -Ss'
alias shutdown='sudo halt -p'
alias sshr='ssh root@192.168.1.1'
alias t='date "+%l:%M" | tr -d " "'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias ucam='sudo umount /mnt/camera/'
alias unas='fusermount3 -u /mnt/nas'
alias update='sudo pacman -Syu'
alias uthumb='sudo umount /mnt/thumb/'
alias webcam='start-webcam'
alias wifi='connect-wifi'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias external='set-screen-layout external'
alias dual='set-screen-layout dual'
alias default='set-screen-layout default'
