# vim: set ft=sh:

# zsh options
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
# PROMPT="%(?..%F{red}%?%f"$'\n'")"\
# $'\n'"%2d"\
# $'\n'"%% "
# PROMPT="%% "

# shift tab to reverse cycle
bindkey '^[[Z' reverse-menu-complete

# environment
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export PYTHONIOENCODING=UTF-8
export LYNX_CFG=~/.lynx/lynx.cfg
export LYNX_LSS=~/.lynx/lynx.lss

# path
# for r_ver in /c/Program\ Files/R/*; do true; done
r="/c/Program Files/R/R-4.3.1/bin/x64"
vim="/c/vim/vim90"
tex="/c/miktex/texmfs/install/miktex/bin/x64"
export PATH="$HOME/scripts:/usr/bin:/c/bin:$r:$tex:$PATH"

# nnn
export EDITOR=/c/vim/vim90/vim
export NNN_BMS='b:/home/jfin;h:/h;d:/c/users/jinman/downloads;p:/r/rb3/shared/basin planning;r:/r/rb3/shared;u:/c/users/jinman'
export NO_COLOR=1

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

# aliases 

# alias mv='mv --no-clobber'
alias R='\R --no-save --quiet'
alias bak='back-up-file'
alias cal='cal -y'
alias cdrelep='cd "/c/Users/jinman/ReLEP"'
alias cdsounds='cd "/c/Users/jinman/OneDrive - Water Boards/Music/Sounds"'
alias cdprojects='cd "/c/Users/jinman/OneDrive - Water Boards/Projects"'
alias cddownloads='cd "/c/Users/jinman/Downloads"'
alias cdjinman='cd "/c/Users/jinman/"'
alias cp='cp --recursive --no-clobber'
alias dash='ENV=~/.shinit dash'
alias dot='git-dot'
alias dott='push-dot-repo'
alias gitt='~/scripts/push-repo'
alias go='open-link'
alias install='pacman -S'
alias jot='take-notes'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias ll='ls -lhF'
alias lock='cmd //c Rundll32.exe user32.dll,LockWorkStation'
alias mdd='convert-markdown-to-word'
alias mvv='rename-files'
alias nnn='nnn -A'
alias path='copy-path'
alias pink='play-tracks -q ~/music/sounds/pink.mp3'
alias play='play-tracks'
alias prod='echo; /c/Program\ Files/R/R-4.3.1/bin/Rscript.exe ~/scripts/get-productivity.r' 
alias proj='take-notes "#proj"'
alias pull='pull-repo'
alias push='push-repo'
alias remove='pacman -Rns'
alias search='pacman -Ss'
alias summary='/c/Program\ Files/R/R-4.2.3/bin/Rscript.exe ~/scripts/get-summary.r $(cygpath -w $LOCALAPPDATA/Programs/msys64/home/JInman/hours)'
alias sync='sync-all-repos'
alias todo='take-notes \#todo'
alias tp='move-to-trash'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias update='pacman -Syu'
alias zrc='vim ~/.zshrc; source ~/.zshrc'

# Automatically start tmux if not already running
if [ -z "$TMUX" ]; then
  tmux attach -t main || tmux new -s main
fi

