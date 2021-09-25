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

pdf() { 
	mupdf $1 &
}

# aliases
alias lsb='doas sysctl hw.disknames'
alias lsbb='doas disklabel -h'
alias bak='backup-file'
alias crc='vim ~/.cwmrc; pkill -HUP cwm'
alias dot='git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias dott='add-push-commit-dot'
alias etc='git --git-dir=/etc/.etc.git/ --work-tree=/etc'
alias etcc='add-push-commit-etc'
alias gitt='add-commit-push'
alias kb='show-key-bindings'
alias krc='vim ~/.kshrc; . ~/.kshrc'
alias l1='ls -1'
alias lA='ls -AlhFd .*'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lynx="lynx -cfg=$HOME/lynx/lynx.cfg -lss=$HOME/lynx/lynx.lss"
alias mvv='batch-rename'
alias pdff='markdown-to-pdf'
alias play='mpv'
alias reboot='sudo reboot'
alias rename='batch-rename'
alias shutdown='sudo halt -p'
alias sshr='ssh root@192.168.1.1'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias unas='fusermount3 -u /mnt/nas'
alias mnas='sshfs rp:/mnt /mnt/nas'
alias vpn='start-vpn'
alias focus='play-sounds'
alias zzz='systemctl hibernate'
alias cans='headphones-connect'
alias ydl='download-playlist'


