
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+r:|[._-]=* r:|=*'
zstyle :compinstall filename '/home/JInman/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats ' %b'  # Note the leading space
zstyle ':vcs_info:*' enable git

PROMPT="
%F{white}%m %~\${vcs_info_msg_0_}
%# %f"

[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/scripts:$PATH" 
PATH="$HOME/.bin:$PATH" 
PATH="$HOME/.local/bin:$PATH" 
if [[ $HOSTNAME == 'WB-102575' ]]; then
    PATH="$HOME/AppData/Roaming/Python/Python312/Scripts:$PATH"
    # get latest r
    for r in "c:/Program Files/R"/*; do
        true
    done
    PATH="/c${r#c:}/bin/x64:$PATH" 
fi
export PATH

# aliases
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotp='dot pull'
alias dots='dot status'
alias gitp='git pull'
alias gits='git status'
alias soz='source ~/.zshrc'
alias sshr='ssh -p 2222 jfin@10.0.0.160'
alias ssht='ssh jfin@10.0.0.27'
alias suspend='set-wake-and-suspend'
alias wol="powershell -ExecutionPolicy Bypass -File ~/scripts/wake-on-lan.ps1"

# functions
# dot add commit push
dott() { 
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME add -u
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME commit -m "${*:-no message}"
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME push
}
gitt() { 
    git add .
    git commit -m "${*:-no message}"
    git push
}

if [[ $HOSTNAME == 'WB-102575' ]]; then
    # source /usr/share/git/completion/git-prompt.sh
    eval $(ssh-agent -s) > /dev/null 
    ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
elif [[ $HOSTNAME == rpi ]]; then
    source ~/scripts/git-prompt.sh
elif [[ $HOSTNAME == t14 ]]; then 
    source /usr/share/git/git-prompt.sh
fi
