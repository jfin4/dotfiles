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
export ming=mingw-w64-x86_64

#prompt
PROMPT=$'\n'"${TMUX:+tmux}%# "

# aliases 

alias R='\R --no-save --quiet'
alias bak='back-up-file'
alias cal='cal -y'
alias cp='cp --recursive --no-clobber'
alias dash='ENV=~/.shinit dash'
alias dot='git-dot'
alias dott='sync-repo -d'
alias gitt='sync-repo'
alias go='open-link'
alias pink='play-tracks -q ~/music/sounds/pink.mp3'
alias play='play-tracks'
alias prod='Rscript ~/scripts/get-productivity.r $(cygpath -w $USERPROFILE/msys/home/jfin/hours)'
alias install='pacman -S'
alias jot='take-notes'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mmd='convert-markdown-to-word'
alias mv='mv --no-clobber'
alias mvv='rename-files'
alias path="copy-path"
alias proj='take-notes #proj'
alias pw='cat ~/passwords/waterboard > /dev/clipboard'
alias remove='pacman -Rns'
alias rm='move-to-trash'
alias search='pacman -Ss'
alias summary='Rscript ~/scripts/get-summary.r $(cygpath -w $USERPROFILE/msys/home/jfin/hours)'
alias sync='sync-repos'
alias todo='take-notes -t'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias update='pacman -Syu'
alias zrc='vim ~/.zshrc; . ~/.zshrc'

# start tmux
if [ -z "$TMUX" ]; then
    tmux 
fi
