# vim: set ft=sh:
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

# options
bindkey -e

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
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
. $HOME/.zsh_aliases

pdf () {
	/usr/bin/zathura "$1" & disown
}

