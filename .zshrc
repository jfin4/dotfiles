# autoload -Uz zsh-newuser-install; zsh-newuser-install -f
# autoload -Uz compinstall; compinstall

# completion
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _expand_alias _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '/c/users/jinman/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# options and variables
setopt extended_glob
bindkey -e

setopt hist_ignore_dups
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=/usr/bin/vim

date=$(date +'%Y-%m-%d')

# prompt
setopt prompt_subst
source ~/.bin/git-prompt.sh
# Set terminal title
precmd() {
    # print -Pn '\e]0;%m\a' # host
    print -Pn '\e]0;%1d\a' # current dir
}
PROMPT='
%F{white}%m %~$(__git_ps1 " %s")
%# %f'

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$HOME/.bin" 
PATH="$PATH:$HOME/.local/bin" 
PATH="$PATH:$initial_path"
export PATH

# aliases

alias -g COPY='> /dev/clipboard'
alias -g QUIET='> /dev/null 2>&1'
alias aw='toggle-alt-win'
alias bat='get-battery-capacity'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotp='dot pull'
alias dots='dot status'
alias dott='add-commit-push-dotfiles'
alias gitp='git pull'
alias gits='git status'
alias gitt='add-commit-push'
alias ll="ls -lh"
alias ls="ls -1F"
alias lynx='/usr/bin/lynx -cfg ~/.lynx/lynx.cfg -lss ~/.lynx/lynx.lss'
alias mpv='mpv --profile=fast'
alias mutt='neomutt'
alias prod='echo; Rscript ~/.bin/get-productivity.r' 
alias pw='get-password'
alias rm='move-to-trash'
alias soz='source ~/.zshrc'
alias sshr='ssh -p 2222 jfin@10.0.0.160'
alias ssht='ssh jfin@10.0.0.27'
alias sshxt='ssh -YC jfin@10.0.0.27'
alias start='launch-file'
alias zzz='set-wake-and-suspend'
alias todo='echo; Rscript ~/.bin/get-todos.r' 
alias wol='powershell -ExecutionPolicy Bypass -File ~/.bin/wake-on-lan.ps1'
alias sig='get-signal-quality'

# host specific
HOSTNAME=${HOSTNAME:-$HOST}
if [[ $HOSTNAME == 'WB-102575' ]]; then
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

elif [[ $HOSTNAME == rpi ]]; then
elif [[ $HOSTNAME == t14 ]]; then 
    # zoxide
    eval "$(zoxide init zsh)"
    alias cd='z' 
    export BROWSER=/usr/bin/firefox
fi

# notes
#
# magic abbreviation
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
