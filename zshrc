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
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(lol ruby mvn node sublime)

source $ZSH/oh-my-zsh.sh

# User configuration

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
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vimz='vim ~/.zshrc'
alias srcz='source ~/.zshrc'
alias gashl='git --no-pager stash list | head'
alias syncco='aws s3 sync . s3://conlinoakley.com/ --profile alexconlin --delete'
alias lst='ls -altr'
alias gi='ge /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias ip='curl curlmyip.org'
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'
alias cdl='cd ~/Movies/lightningtalks'
alias cdm='cd ~/Movies'
alias rslt='rsync /Volumes/Untitled/MP_ROOT/100ANV01/MAH*.MP4 /Users/aconlin-oakley/Movies/lightningtalks --ignore-existing'
alias glb='gl --invert-grep --grep=Autobumper'
alias rsync='rsync --progress'
alias rofl='sudo ifconfig en0 down && sudo gtimeout 1s route flush && sleep 1 && sudo ifconfig en0 up'
alias cleandb='gradle -b ~/code/ideas/build.gradle :TIMWeb:databases:importDb-minimal'
alias gashu='git stash save --include-untracked'
alias bel="echo -en '\a'"
alias geo='ge /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias gh='lpass show 5086150539736595802 --field=Passphrase -c'
alias lynx='lynx -cfg=~/.lynx.cfg'
alias gpla='find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'
alias gpp='gpl && gps'
alias gn='git --no-pager'

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

# rbenv
eval "$(rbenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# go
export GOPATH=/Users/aconlin-oakley/lib/go
export PATH=$GOPATH/bin:$PATH

# personal variables
export TRA=":twisted_rightwards_arrows:"
export HPS=":heavy_plus_sign:"

# rust
export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib

# pager
export PAGER="most"

# auto connect to tmux on remote server
version_gt() {
    test "$(echo "$@" | tr " " "\n" | gsort -V | head -n 1)" != "$1";
}
alex() {
    version_gt 1.7 1.8
}
ssh() {
    tmuxver=$(/usr/bin/ssh -q -t $@ "tmux -V")
    if (test $? -eq 0)
    then
        ver=$(echo $tmuxver | cut -d' ' -f2-)
        echo $ver
        if (version_gt $ver 2.1)
        then
            echo here1
            tmuxloc="/Users/aconlin-oakley/.tmux.conf" 
        else
            echo here2
            tmuxloc="/Users/aconlin-oakley/.tmux-1.8.conf"
        fi
        scp $tmuxloc ${@: -1}:/home/aconlin-oakley/.tmux.conf || return 1
        /usr/bin/ssh -t $@ "tmux -f /home/aconlin-oakley/.tmux.conf -2u attach || tmux -f /home/aconlin-oakley/.tmux.conf -2u new";
    else
        /usr/bin/ssh $@;
    fi
}
alias ubssh='/usr/bin/ssh'

# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/github/hub
eval "$(hub alias -s)"

# http://git.youdevise.com/gitweb/?p=stackbuilder-config.git;a=tree;f=docker;h=1feb1b1b44734a8930a28e650d71601e758ef351;hb=HEAD
alias stacks='docker run --rm -e "MCOLLECTIVE_SSL_PRIVATE=~/.ssh/id_rsa" -e "MCOLLECTIVE_SSL_PUBLIC=~/.ssh/id_rsa.pem" -v "/Users/aconlin-oakley/code/stackbuilder-config":/git -v "$HOME/.mc:/mc" --volumes-from=ssh-agent -e "SSH_AUTH_SOCK=/.ssh-agent/socket" timgroup-stacks'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Android dev / React Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/aconlin-oakley/.nvm/versions/node/v8.9.4/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/aconlin-oakley/.nvm/versions/node/v8.9.4/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

export MOST_SWITCHES="-w"

PROMPT='${ret_status} %D %* %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

