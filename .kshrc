# options
set -o emacs
bind ^l=clear-screen
bind -m ^xd="$(date +'%Y-%m-%d')"

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# PS1
export PS1='\e[01;31m$(x=$?; (( $x )) && printf ":( $x\\\\n")\e[00m
\e[01;30m$PWD\e[00m
\e[01;30m\$ \e[00m'

# set memory to something high
ulimit -d $(( 8 * 1024 * 1024 )) # 8 Gb, max is 32, installed is 16

#functions
pdf() { 
	mupdf $1 &
}

fvim() {
	vim $( fd | fzy)
}

# aliases
alias ZZZ='systemctl hibernate'
alias bak='backup-file'
alias cans='headphones-connect'
alias cants='headphones-disconnect'
alias crc='vim ~/.cwmrc; pkill -HUP cwm'
alias dot='git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias dott='add-push-commit-dot'
alias etc='git --git-dir=/etc/.etc.git/ --work-tree=/etc'
alias etcc='add-push-commit-etc'
alias focus='play-sounds'
alias gitt='add-commit-push'
alias install='sudo pacman -S'
alias kb='show-key-bindings'
alias krc='vim ~/.kshrc; . ~/.kshrc'
alias l1='ls -1'
alias lA='ls -AlhFd .*'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lsb='doas sysctl hw.disknames'
alias lsbb='doas disklabel -h'
alias lynx="lynx -cfg=$HOME/lynx/lynx.cfg -lss=$HOME/lynx/lynx.lss"
alias mnas='sshfs rp:/mnt /mnt/nas'
alias mvv='batch-rename'
alias note='take-notes'
alias pdff='markdown-to-pdf'
alias play='mpv'
alias reboot='sudo reboot'
alias remove='sudo pacman -R'
alias rename='batch-rename'
alias search='sudo pacman -Ss'
alias shutdown='sudo halt -p'
alias sshr='ssh root@192.168.1.1'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias unas='fusermount3 -u /mnt/nas'
alias update='sudo pacman -Syu'
alias vpn='start-vpn'
alias ydl='download-playlist'
alias zzz='systemctl suspend'


