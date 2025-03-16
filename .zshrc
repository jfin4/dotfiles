# options

# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

setopt sh_word_split
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history
setopt extended_glob

# prompt variaible
unset precmd_functions # clear this each time config is sourced
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT="%(?..%F{red}%?
%f)
%F{white}${TMUX:+tmux }%d \${vcs_info_msg_0_:+< \$vcs_info_msg_0_}
%% %f"

# export PS1='\[\033]0;${PWD##*/}\007\]\n\w`__git_ps1`\n$ '

# zsh variables
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# standard variables
# export BROWSER='c:/Program Files/Mozilla Firefox/firefox.exe'
# export VISUAL=nvim
# export EDITOR=$VISUAL

# shortcut variables
export dd=$(date +%Y-%m-%d)

# vcxsrv variables for ssh -Y rpi
export DISPLAY='localhost:0.0'

# completion

# autoload -Uz compinstall
# compinstall

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/jinman/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# git
# speed up completion in git repos
# https://stackoverflow.com/questions/9810327/
# zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off/
# 9810485#9810485
__git_files () { 
    _wanted files expl 'local files' _files  
}

# fzf

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='kk'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# key mappings

bindkey -e
bindkey '^[[Z' reverse-menu-complete

# aliases 

alias aws_ssh='ssh -i /home/JInman/.ssh/LightsailDefaultKey-us-west-2.pem admin@54.148.13.14'
alias bak='back-up-file'
alias brown='play-files "c:/users/JInman/OneDrive - Water Boards/Music/Sounds/brownnoise.mp3"'
alias c='cygstart'
alias cal='cal -y'
alias cp='cp --recursive --no-clobber'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias lf='lf -config ~/.config/lf/lfrc'
alias ll='ls -l --time-style=long-iso --classify --human-readable'
alias ls='ls --format=single-column --classify'
alias mdd='convert-markdown-to-word'
alias mvv='rename-files'
alias notes='cd ~/notes; search-files "" notes.txt; cd -'
alias todo='cd ~/notes; search-files "#todo" notes.txt; cd -'
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias pw='get-password'
alias rm='~/scripts/move-to-trash'
alias rmm='/usr/bin/rm -rf'
alias sot='tmux source-file ~/.tmux.conf'
alias soz='source ~/.zshrc'
alias tanpura='play-sounds "c:/users/JInman/OneDrive - Water Boards/Music/Sounds/tanpura.mp3"'
alias txt_to_xl='Rscript ~/scripts/text-to-excel.r'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias xl_to_txt='Rscript ~/scripts/excel-to-text.r'
alias p='pacman'
alias open='open-link'

# start tumx
if [ -z $TMUX ]; then
    pacman -Syu --noconfirm
    tmux
fi

# future ideas
#
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
