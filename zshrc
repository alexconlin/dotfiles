zmodload zsh/zprof
if [[ $(uname) == 'Darwin' ]]
then
    ENVIR="osx";
else
    ENVIR="linux";
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=()

# Alex custom - fix slow paste when large
DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

# User configuration
source ~/dotfiles/.secrets

export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=${PATH}:/bin
PATH=${PATH}:/sbin
PATH=${PATH}:/usr/bin
PATH=${PATH}:/usr/sbin
PATH=${PATH}:/opt/local/bin
PATH=${PATH}:/opt/local/sbin
PATH=${PATH}:/usr/local/git/bin
PATH=${PATH}:/usr/local/git/sbin
PATH=${PATH}:/Users/aconlin-oakley/.local/bin
PATH=${PATH}:/Users/aconlin-oakley/lib/sonar-scanner-2.5/bin
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"

export GROOVY_HOME=/usr/local/opt/groovy@2.4.3/libexec

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias vimz='vim ~/.zshrc'
alias srcz='source ~/.zshrc'
alias gashl='git --no-pager stash list | head'
alias gpsu='git push -u origin HEAD'
alias syncco='aws s3 sync . s3://conlinoakley.com/ --profile alexconlin --delete'
alias lst='ls -altr'
alias gi='ge /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'
alias cdl='cd ~/Movies/lightningtalks'
alias cdm='cd ~/Movies'
alias rslt='rsync /Volumes/Untitled/MP_ROOT/100ANV01/MAH*.MP4 /Users/aconlin-oakley/Movies/lightningtalks --ignore-existing'
alias glb='gl --invert-grep --grep=Autobumper'
alias rsync='rsync --progress'
alias rofl='sudo ifconfig en0 down && sudo gtimeout 1s route flush && sleep 1 && sudo ifconfig en0 up'
alias gashu='git stash save --include-untracked'
alias bel="echo -en '\a'"
alias geo='ge /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias lynx='lynx -cfg=~/.lynx.cfg'
alias gpla='find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'
alias gpp='gpl && gps'
alias gn='git --no-pager'
alias cdd='cd ~/dotfiles'
alias vim='nvim'
alias vi='nvim'
alias vimv='vim ~/.config/nvim/init.vim'
alias ag='rg'
alias vimt='vim ~/.tmux.conf'
alias glt="git log --graph --pretty=format:'%Cred%h%Creset -%s %Cgreen(%cd) %C(bold magenta)<%an>%Creset' --abbrev-commit"
alias dc="cd"
alias cat="bat"

mkdircd() {
    mkdir $1 && cd $1
}

gclt() {
    git clone git@git.net.local:$1
}

# Writing it as a function removes the need to escape the quotes :)
pipeline() {
    pbpaste | sed 's/\\"/"/g' | sed 's/\\\\"/"/g' | sed 's/"{/{/g' | sed 's/}"/}/g' | pbcopy
}

# Setup tab and window title functions for iterm2
# iterm behaviour: until window name is explicitly set, it'll always track tab title.
# So, to have different window and tab titles, iterm_window() must be called
# first. iterm_both() resets this behaviour and has window track tab title again).
# Source: http://superuser.com/a/344397
set_iterm_name() {
  mode=$1; shift
  echo -ne "\033]$mode;$@\007"
}
iterm_both () { set_iterm_name 0 $@; }
iterm_tab () { set_iterm_name 1 $@; }
iterm_window () { set_iterm_name 2 $@; }

# HOME
if [[ "$ENVIR" == "osx" ]] then
    export HOMEBREW_CASK_OPTS='--appdir=/Applications'
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
fi
# EDITING MODE (VI) (from http://dougblack.io/words/zsh-vi-mode.html)
bindkey -v
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
#bindkey '\e[A' history-beginning-search-backward
#bindkey '\e[B' history-beginning-search-forward
# Terminal colors for vim solarized theme
# export TERM=screen-256color-bce

source /Users/aconlin-oakley/.iterm2_shell_integration.zsh

# go
export GOPATH=/Users/aconlin-oakley/lib/go
export PATH=$GOPATH/bin:$PATH

# personal variables
export TRA=":twisted_rightwards_arrows:"
export HPS=":heavy_plus_sign:"

# rust
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib
export PATH="$HOME/.cargo/bin:$PATH"

# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# http://git.youdevise.com/gitweb/?p=stackbuilder-config.git;a=tree;f=docker;h=1feb1b1b44734a8930a28e650d71601e758ef351;hb=HEAD
alias stacks='docker run --rm -e "MCOLLECTIVE_SSL_PRIVATE=~/.ssh/id_rsa" -e "MCOLLECTIVE_SSL_PUBLIC=~/.ssh/id_rsa.pem" -v "/Users/aconlin-oakley/projects/stackbuilder-config":/git -v "$HOME/.mc:/mc" --volumes-from=ssh-agent -e "SSH_AUTH_SOCK=/.ssh-agent/socket" timgroup-stacks'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# Android dev / React Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

export MOST_SWITCHES="-w"

PROMPT='${ret_status} %D %* %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# export PATH="/usr/local/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/usr/local/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

#source <(kubectl completion zsh)
alias k=kubectl
#complete -F __start_kubectl k
alias kpg='kubectl --context pg'
#complete -F __start_kubectl kpg
alias koy='kubectl --context oy'
#complete -F __start_kubectl koy
alias koyt='kubectl --context oytest'
#complete -F __start_kubectl koyt
kexec() {
  kubectl -n "$1" exec -it $(kubectl -n "$1" get pod -l stack="$2" -o json | jq -r '.items[0].metadata.name') /bin/bash
}
alias kc='kubectx'
alias kn='kubens'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
#alias kubectl='nocorrect kubectl'
#export KUBECONFIG=~/.kube/config:~/.kube/metricsdev_kubeconfig:~/.kube/metricsprod_kubeconfig

#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

cidrip() {
  nmap -sL $1 | awk '/Nmap scan report/{print $NF}' | sed -e 1b -e '$!d' | tr '\n' ',' | sed 's/,$//'
}

source /Users/aconlin-oakley/Library/Preferences/org.dystroy.broot/launcher/bash/br

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case-sensitive matching with insensitive fallback

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Speed up zsh compinit by only checking cache once a day
# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

. /usr/local/opt/asdf/libexec/asdf.sh

. ~/.asdf/plugins/java/set-java-home.zsh

# prefer homebrew version on sqlite3
export PATH="$(brew --prefix)/opt/sqlite/bin:$PATH"

# prefer coreutils versions
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"

# set up awscli completion
export PATH=/usr/local/bin/aws_completer:$PATH

graphml2boxart() {
  cat $1 | graphml2gv 2>/dev/null | dot | /usr/local/Cellar/perl/5.32.0/bin/graph-easy --as boxart 2>/dev/null
}

wdavlastscan() {
  sudo cat '/Library/Application Support/Microsoft/Defender/wdavhistory' | jq -r '.scans | sort_by(.endTime) | reverse | first | { startTime: (.startTime | tonumber  / 1000 | todate), endTime: (.endTime | tonumber  / 1000 | todate) }'
}

setopt autocd
cdpath=($HOME/projects)

