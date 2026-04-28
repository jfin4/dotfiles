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
bindkey '^[[Z' reverse-menu-complete


setopt hist_ignore_all_dups
setopt share_history
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
alias -g JFIN='jfin-wb@10.0.0.235:unsorted'
alias -g QUIET='> /dev/null 2>&1 & disown'
alias ZZZ='sudo pacman -Syu --noconfirm; sudo shutdown now'
alias aider='aider --model openrouter/openai/gpt-oss-120b:free --no-pretty'
alias aw='toggle-alt-win'
alias bat='get-battery-capacity'
alias calaters='start ~/notes/docs/calaters.jnlp'
alias cp='cp -r'
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
alias mutt='cd ~/unsorted; /usr/bin/mutt; cd -'
alias prod='echo; Rscript ~/.bin/get-productivity.r' 
alias pw='get-password'
alias reboot='sudo pacman -Syu --noconfirm; reboot'
alias rm='move-to-trash'
alias sig='get-signal-quality'
alias sjfin='ssh jfin@jfin'
alias skaren='ssh jfin@karen'
alias skids='ssh jfin@kids'
alias snas='ssh jfin@nas'
alias sod='\cd ~/.aur/dwm; makepkg -sfic; \cd -'
alias sot='tmux source-file ~/.tmux.conf'
alias soz='source ~/.zshrc'
alias srpi='ssh -p 2222 jfin@rpi'
alias ssht='ssh jfin@10.0.0.27'
alias sshxt='ssh -YC jfin@10.0.0.27'
alias start='launch-file'
alias todo='echo; Rscript ~/.bin/get-todos.r' 
alias wol='powershell -ExecutionPolicy Bypass -File ~/.bin/wake-on-lan.ps1'
alias zzz='sudo systemctl suspend'

# host specific
os=$(uname)
if [[ $os == MINGW64_NT-10.0-26200 ]]; then
    
    export EDITOR=/usr/bin/vim
    
    # use local time, doesn't recognize 'Americal/Los_Angeles'
    export TZ='PST8PDT'
    
    # path
    sumatra="/c/users/jinman/AppData/Local/SumatraPDF"
    # get latest r
    for v in /c/Program\ Files/*; do r="$v/bin/x64"; done
    export PATH="$PATH:$sumatra:$r"
    
    # shh; needs procps-ng
    pgrep ssh-agent || eval $(ssh-agent -s) > /dev/null 
    ssh-add ~/.ssh/id_ed25519 > /dev/null

    # zoxide
    eval "$(zoxide init zsh)"
    alias cd='z' 

    # update and start tmux
    if [[ -z $TMUX ]]; then
        tmux
    fi

elif [[ $os == OpenBSD ]]; then

    export EDITOR=/usr/local/bin/vim

elif [[ $os == Linux ]]; then 
    
    export BROWSER=/usr/bin/firefox
    export EDITOR=/usr/bin/vim

    # zoxide
    eval "$(zoxide init zsh)"
    alias cd='z' 


fi > /dev/null 2>&1

# notes
#
# magic abbreviation
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
