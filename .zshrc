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
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT="%(?..%F{red}%?%f"$'\n'")"\
$'\n'"%2d\${vcs_info_msg_0_:+ -< \$vcs_info_msg_0_}"\
$'\n'"${TMUX+tmux }%% "

# zsh variables
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# bookmark variables
export bbo='c:/Users/jinman/OneDrive - Water Boards/'
export bbp='c:/Users/jinman/OneDrive - Water Boards/Projects/'
export bbr='c:/Users/jinman/Desktop/Final_ReLEP/'
export bbu='c:/users/jinman/'
export bbd='c:/Users/jinman/Downloads/'
export bba='c:/Users/jinman/AppData/Local/'

# shortcut variables
export dd=$(date +%Y-%m-%d)
export mm='mingw-w64-ucrt-x86_64-'

# avante variables
export ANTHROPIC_API_KEY=$(pass anthropic.com/default-api-key)
export OPENAI_API_KEY=$(pass openai.com/default-api-key)
export DEEPSEEK_API_KEY=$(pass deepseek.com/default-api-key)

# nvim variables
export XDG_CONFIG_HOME="$HOME/.config"

# vcxsrv variables for ssh -Y rpi
export DISPLAY='localhost:0.0'

# go variables
export GOPATH=$(cygpath -w $HOME/.go)
export GOROOT=$(cygpath -w /ucrt64/lib/go)

# java variables
JAVA_HOME='/c/Program Files (x86)/Java/jre-1.8/bin'

# path
[ -z "$initial_path" ] && export initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/.cargo/bin:$PATH" 
PATH="$HOME/.go/bin:$PATH" 
PATH="$HOME/.python/bin:$PATH" 
PATH="$HOME/scripts:$PATH" 
PATH="$JAVA_HOME:$PATH" 
PATH="/c/programs/ffmpeg/bin:$PATH"
PATH="/c/programs/pandoc:$PATH" 
PATH="/c/programs/r/bin/x64:$PATH" 
PATH="/c/programs/sumatrapdf:$PATH" 
PATH="/c/programs/texlive/2024/bin/windows:$PATH" 
PATH="/c/programs/yt-dlp:$PATH"
export PATH

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
export FZF_COMPLETION_TRIGGER='ii'

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
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias rmm='/usr/bin/rm -rf'
alias tanpura='play-files "c:/users/JInman/OneDrive - Water Boards/Music/Sounds/tanpura.mp3"'
alias trc='vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
alias txt_to_xl='Rscript ~/scripts/text-to-excel.r'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias vim='nvim'
alias xl_to_txt='Rscript ~/scripts/excel-to-text.r'
alias zrc='vim ~/.zshrc; source ~/.zshrc'
alias rm='~/scripts/move-to-trash'

# start tumx
if [ -z $TMUX ]; then
    pacman -Syu --noconfirm
    tmux
fi
