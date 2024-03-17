# vim: set ft=sh:

# options
bindkey -e
setopt sh_word_split
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history
setopt extended_glob

# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f
# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jfin/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT="%(?..%F{red}%?%f"$'\n'")"\
$'\n'"%2d\${vcs_info_msg_0_:+ -< \$vcs_info_msg_0_}"\
$'\n'"${TMUX+tmux }%% "

# shift tab to reverse cycle
bindkey '^[[Z' reverse-menu-complete

# environment
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# path
export PATH=".:$HOME/.aliases:$HOME/scripts:$PATH"

# other variables
export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export BROWSER=/usr/bin/firefox
export _JAVA_AWT_WM_NONREPARENTING=1


# functions
insert_date () { 
	LBUFFER+=${(%):-'%D{%Y-%m-%d}'};
}
zle -N insert_date
bindkey '^xd' insert_date

passgen () {
  pass_name="$1"
  if [ -z $pass_name ]; then
    echo 'usage: passgen PASS_NAME [ LENGTH ] [ SYMBOLS ]'
    echo use PASS_NAME temp to not create store
    return
  fi
  pass_length="${2-12}"
  symbols="${3-!@#\$%^&*()}"
  if [ $pass_name = "temp" ]; then
    PASSWORD_STORE_CHARACTER_SET="a-zA-Z0-9$symbols"\
      pass generate temp/temp $pass_length
    unset pass_length symbols PASSWORD_STORE_CHARACTER_SET
    pass temp/temp > /dev/clipboard
    pass rm --force temp/temp
    return
  fi
  PASSWORD_STORE_CHARACTER_SET="a-zA-Z0-9$symbols"\
    pass generate $pass_name $pass_length
  unset pass_length symbols PASSWORD_STORE_CHARACTER_SET
} 

pw () {
  query="${1-.}"
  pass_stores=$(ls ~/.password-store/*/* | sed -e 's/.*password-store\/\(.*\)\.gpg/\1/')
  pass_store=$(echo "$pass_stores" | fzy --query="$query")
  pass $pass_store | tee /dev/clipboard
}

rm () {
  mv --backup=numbered "$@" "$HOME"/trash/
}

zathura () {
	/usr/bin/zathura "$1" & disown
}
mpv () {
	/usr/bin/mpv --save-position-on-quit --volume-max=200 $1 & disown
}

# aliases

alias R='start-r'
alias alarm='set-alarm'
alias arc='vim ~/.config/awesome/rc.lua'
alias bak='backup-file'
alias bt='manage-bluetooth'
alias capsescape='setxkbmap -option caps:escape'
alias crc='vim ~/.cwmrc; pkill -HUP cwm'
alias default='set-screen-layout default'
alias deorphan='sudo pacman -Qtdq | sudo pacman -Rns -'
alias dot='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dual='set-screen-layout dual'
alias external='set-screen-layout external'
alias fd='wrap-find'
alias ff='fuzzy-find-file'
alias focus='play-focus-playlist'
alias install='sudo pacman -S'
alias ji='pandoc --template ~/.pandoc/johninman.dev --metadata title="John Inman" -o index.html'
alias jot='take-notes'
alias kb='get-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lynx="lynx -cfg=$HOME/.lynx/lynx.cfg -lss=$HOME/.lynx/lynx.lss"
alias mam='rtorrent -n -o import=~/.rtorrent-mam.rc'
alias mcam='sudo mount /dev/disk/by-label/camera /mnt/camera/'
alias mobile='connect-mobile'
alias mphone='ifuse /mnt/phone'
alias mrpi='sshfs rpi:/ /mnt/rpi/'
alias mthumb='sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
alias mutt='cd ~/downloads/ && mutt && cd -'
alias mv='mv --no-clobber'
alias mvv='rename-files'
alias off='turn-off-screen'
alias p='pwd'
alias pad='toggle-numpad'
alias reboot='sudo reboot'
alias remove='sudo pacman -Rs'
alias rsync='rsync -ahP'
alias search='sudo pacman -Ss'
alias shutdown='sudo halt -p'
alias sshr='ssh root@192.168.1.1'
alias t='date "+%l:%M" | tr -d " "'
alias tm='toggle-mod-key'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias ubak='restore-file'
alias ucam='sudo umount /mnt/camera/'
alias update='sudo pacman --sync --refresh --sysupgrade && sudo pacman --sync --clean --noconfirm'
alias uphone='fusermount -u /mnt/phone'
alias urpi='sudo umount /mnt/rpi/'
alias uthumb='sudo umount /mnt/thumb/'
alias vpn='set-vpn'
alias webcam='start-webcam'
alias wifi='connect-wifi'
alias ydl='download-playlist'
alias zrc='vim ~/.zshrc; . ~/.zshrc'


if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

