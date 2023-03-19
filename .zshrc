
# vim: set ft=sh:
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

# options
bindkey -e


# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

# alias cal='show-calendar'

alias R='start-r'
alias alarm='set-alarm'
alias arc='vim ~/.config/awesome/rc.lua'
alias bak='backup-file'
alias bt='connect-bluetooth'
alias crc='vim ~/.cwmrc; pkill -HUP cwm'
alias default='set-screen-layout default'
alias deorphan='sudo pacman -Qtdq | sudo pacman -Rns -'
alias dot='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dott='sync-dot-repo'
alias dual='set-screen-layout dual'
alias external='set-screen-layout external'
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
alias mam='rtorrent -n -o import=~/.rtorrent-mam.rc'
alias mcam='sudo mount /dev/disk/by-label/camera /mnt/camera/'
alias mobile='connect-mobile'
alias mphone='ifuse /mnt/phone'
alias mpv='mpv --save-position-on-quit'
alias mrpi='sshfs rpi:/ /mnt/rpi/'
alias mthumb='sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
alias mutt='cd ~/downloads/ && mutt && cd'
alias mv='mv --no-clobber'
alias mvv='rename-files'
alias off='turn-off-screen'
alias p='pwd'
alias pad='toggle-numpad'
alias reboot='sudo reboot'
alias remove='sudo pacman -R'
alias search='sudo pacman -Ss'
alias shutdown='sudo halt -p'
alias sshr='ssh root@192.168.1.1'
alias t='date "+%l:%M" | tr -d " "'
alias tm='toggle-mod-key'
alias tmux='tmux attach || tmux'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias ucam='sudo umount /mnt/camera/'
alias update='sudo pacman -Syu'
alias uphone='fusermount -u /mnt/phone'
alias urpi='sudo umount /mnt/rpi/'
alias uthumb='sudo umount /mnt/thumb/'
alias vpn='set-vpn'
alias webcam='start-webcam'
alias wifi='connect-wifi'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias ji='pandoc --template ~/.pandoc/johninman.dev --metadata title="John Inman" -o index.html'

pdf () {
	/usr/bin/zathura "$1" & disown
}

