# vim: set ft=sh:
##############################################################################
#                                  options                                   #
##############################################################################

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
    eval 'LBUFFER="$LBUFFER$file"'
    zle reset-prompt
}
zle -N get-file
bindkey "^t" "get-file"

function jot() . $HOME/scripts/take-notes

##############################################################################
#                                 aliases                                    #
##############################################################################

alias R='start-r'
alias bak='backup-file'
alias d='date "+%H:%M"'
alias d='pwd'
alias dot='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dott='sync-dot-repo'
alias fd='wrap-find'
alias ff='fuzzy-find-file'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias gittt='sync-all-repos'
alias hp='connect-headphones'
alias install='sudo pacman -S'
alias kb='show-key-bindings'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lynx="lynx -cfg=$HOME/.lynx/lynx.cfg -lss=$HOME/.lynx/lynx.lss"
alias mcam='sudo mount /dev/disk/by-label/camera /mnt/camera/'
alias mnas='sshfs rp:/mnt /mnt/nas'
alias mthumb='sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
alias mvv='rename-files'
alias p='pwd'
alias pad='toggle-numpad'
alias play='mpv'
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
alias ydl='download-playlist'

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=** l:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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
    eval 'LBUFFER="$LBUFFER$file"'
    zle reset-prompt
}
zle -N get-file
bindkey "^t" "get-file"

##############################################################################
#                                 aliases                                    #
##############################################################################

alias R='start-r'
alias ZZZ='systemctl hibernate'
alias bak='backup-file'
alias d='date "+%H:%M"'
alias d='pwd'
alias dot='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dott='sync-dot-repo'
alias fd='wrap-find'
alias ff='fuzzy-find-file'
alias focus='play-focus-playlist'
alias gitt='sync-repo'
alias gittt='sync-all-repos'
alias hp='connect-headphones'
alias install='sudo pacman -S'
alias jot='take-notes'
alias kb='show-key-bindings'
alias krc='vim ~/.mkshrc; . ~/.mkshrc'
alias zrc='vim ~/.zshrc; . ~/.zshrc'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lynx="lynx -cfg=$HOME/.lynx/lynx.cfg -lss=$HOME/.lynx/lynx.lss"
alias mcam='sudo mount /dev/disk/by-label/camera /mnt/camera/'
alias mnas='sshfs rp:/mnt /mnt/nas'
alias mthumb='sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
alias mvv='rename-files'
alias p='pwd'
alias pad='toggle-numpad'
alias play='mpv'
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
alias ydl='download-playlist'
alias zzz='systemctl suspend'
alias bat='notify-battery'
alias cmd='. /home/jfin/scripts/run-command'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
