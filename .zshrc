HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

PROMPT=$'\n%F{red}%(?..%? )%f%B%F{black}%~>%f%b '

setopt extendedglob
bindkey -e
zstyle :compinstall filename '/home/jfin/.zshrc'
autoload -Uz compinit
compinit
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

alias cans='sudo bluetoothctl connect 70:26:05:CF:75:A1'
alias cants='sudo bluetoothctl disconnect 70:26:05:CF:75:A1'
alias cdn='cd /media/share'
alias cds='cd /media/storage'
alias dot='git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias iwd='sudo systemctl restart iwd.service && status'
alias la='ls -lha --color'
alias ll='ls -lh --color'
alias mmem='sudo mount -o uid=1001,gid=1001 /dev/disk/by-id/mmc-SM16G_0xb36600c8-part1 /media/memcard'
alias mphone='sudo ifuse -o allow_other /media/phone'
alias mpv='mpv --audio-display=no'
alias mshare='sudo mount -o soft 192.168.1.1:/mnt/jfin /media/share'
alias mthumb='sudo mount -o uid=1000,gid=1000 /dev/disk/by-label/THUMB /media/thumb'
alias owrt='ssh root@192.168.1.1'
alias tp='trash'
alias umem='sudo umount /media/memcard'
alias uphone='sudo umount /media/phone'
alias ushare='sudo umount /media/share'
alias uthumb='sudo umount /media/thumb'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias zzz='systemctl suspend'
alias ZZZ='sudo shutdown now'
