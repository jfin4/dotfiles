
# vim: ft=zsh foldenable

# options
bindkey -e
setopt sh_word_split
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history
setopt extended_glob

# environment variables
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
EDITOR=/c/vim/vim90/vim
MINGW_PACKAGE_PREFIX=mingw-w64-ucrt-x86_64

# completion

# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[/ ]=** r:|=**' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jinman/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
bindkey '^[[Z' reverse-menu-complete

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT="%(?..%F{red}%?%f"$'\n'")"\
$'\n'"%2d\${vcs_info_msg_0_:+ -< \$vcs_info_msg_0_}"\
$'\n'"rpi %% "

# insert date
insert_date () { 
	LBUFFER+=${(%):-'%D{%Y-%m-%d}'};
}
zle -N insert_date
bindkey '^@d' insert_date

# password management
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

# Paste the selected file path(s) into the command line
select_paths() {
  fd_cmd="fdfind\
    --hidden\
    --no-ignore\
    $type"
  fzf_cmd="fzf\
    --height 40%\
    --multi\
    --reverse\
    --scheme=path"
  $fd_cmd | $fzf_cmd | while read path; do
    echo -n " '$path'"
  done
}
paste_paths() {
  # * allow for spaces after command
  if [[ ${LBUFFER} == cd* ]]; then
    type="--type=directory"
  elif [[ ${LBUFFER} == vim* ]]; then
    type="--type=file"
  else
    type=""
  fi
  OLD_LBUFFER="$LBUFFER"
  LBUFFER="${LBUFFER}$(select_paths $type)"
  if [[ "${LBUFFER}" == "${OLD_LBUFFER}" ]]; then
    zle kill-whole-line
  else
    zle accept-line
  fi
  zle reset-prompt
}
zle -N paste_paths
bindkey '^@' paste_paths

# aliases 
alias R='\R --no-save --quiet'
alias bak='back-up-file'
alias cal='cal -y'
alias cddownloads='cd "/c/Users/jinman/Downloads"'
alias cdjinman='cd "/c/Users/jinman/"'
alias cdprojects='cd "/c/Users/jinman/OneDrive - Water Boards/Projects"'
alias cdrelep='cd "/c/Users/jinman/ReLEP"'
alias cdsounds='cd "/c/Users/jinman/OneDrive - Water Boards/Music/Sounds"'
alias cduserprofile='cd "/c/Users/jinman/"'
alias cp='cp --recursive --no-clobber'
alias dash='ENV=~/.shinit dash'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
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
alias fd='fdfind'

