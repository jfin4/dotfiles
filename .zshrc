# autoload -Uz zsh-newuser-install; zsh-newuser-install -f
# autoload -Uz compinstall; compinstall

# completion
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/jfin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# options and variables
setopt extended_glob
bindkey -e

# home, end, delete
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char


setopt hist_ignore_dups
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

date=$(date +'%Y-%m-%d')

# prompt
setopt prompt_subst
source ~/.bin/git-prompt.sh
# Set terminal title
# precmd() {
#     # print -Pn '\e]0;%m\a' # host
#     print -Pn '\e]0;%1d\a' # current dir
# }
PROMPT='
%F{white}%n@%m:%~$(__git_ps1 " %s")
%# %f'

# aliases

alias -g COPY='> /dev/clipboard'
alias -g QUIET='> /dev/null 2>&1 & disown'
alias aw='toggle-alt-win'
alias bat='get-battery-capacity'
alias calaters='start ~/notes/docs/calaters.jnlp'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotp='dot pull'
alias dots='dot status'
alias dott='add-commit-push-dotfiles'
alias gitp='git pull'
alias gits='git status'
alias gitt='add-commit-push'
alias jfin='sudo -u jfin -s env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native zsh'
alias la="ls -lha"
alias ll="ls -lh"
alias ls="ls -1F"
alias lynx='/usr/bin/lynx -cfg ~/.lynx/lynx.cfg -lss ~/.lynx/lynx.lss'
alias mpv='mpv --profile=fast --hwdec=auto --sid=no --fullscreen'
alias mutt='cd ~/downloads; neomutt; cd -'
alias prod='echo; Rscript ~/.bin/get-productivity.r' 
alias pw='get-password'
alias rm='move-to-trash'
alias sig='get-signal-quality'
alias soz='source ~/.zshrc'
alias sot='tmux source-file ~/.tmux.conf'
alias sod='\cd ~/.packages/dwm-suckless; sudo make clean install; \cd -'
alias srpi='ssh -p 2222 jfin@rpi'
alias skaren='ssh jfin@karen'
alias skids='ssh jfin@kids'
alias ssht='ssh jfin@10.0.0.27'
alias sshxt='ssh -YC jfin@10.0.0.27'
alias snas='ssh jfin@nas'
alias sjfin='ssh jfin@jfin'
alias start='launch-file'
alias todo='echo; Rscript ~/.bin/get-todos.r' 
alias wol='powershell -ExecutionPolicy Bypass -File ~/.bin/wake-on-lan.ps1'
alias zzz='sudo systemctl suspend'

# host specific
os=$(uname)
if [[ $os == MINGW64_NT-10.0-26200 ]]; then
    
    # # shh 
    # eval $(ssh-agent -s) > /dev/null 
    # ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1

    # path
    PATH="$PATH:/c/Program Files/Python312"
    PATH="$PATH:/c/Program Files/Python312/Scripts"
    # get latest r
    for r in "c:/Program Files/R"/*; do
        true
    done
    PATH="$PATH:/c${r#c:}/bin/x64" 
    export PATH

    # use local time, doesn't recognize 'Americal/Los_Angeles'
    export TZ='PST8PDT'
    
    # zoxide
    eval "$(zoxide init zsh)"
    alias cd='z' 


    # update and start tmux
    if [[ -z $TMUX ]]; then
        pacman -Syuu --noconfirm
        tmux
    fi

elif [[ $os == OpenBSD ]]; then

    export EDITOR=/usr/local/bin/vim

elif [[ $os == Linux ]]; then 
    
    # zoxide
    eval "$(zoxide init zsh)"
    alias cd='z' 
    alias ZZZ='sudo shutdown now'
    export BROWSER=/usr/bin/firefox
    export EDITOR=/usr/bin/vim
    if [[ $USER == jfin-wb ]]; then 
        xhost +SI:localuser:jfin 
    fi

fi > /dev/null 2>&1

# notes
#
# magic abbreviation
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
