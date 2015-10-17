if [[ $(uname) == 'Darwin' ]]
then
    ENVIR="osx";
    if [[ $(hostname) == 'alexs-grabyo-macbook-pro' ]]
    then
        GRABYOPATH="/Users/alexgrabyo/grabyo"
        GITHOMEPATH="/Users/alexgrabyo"
    else
        GRABYOPATH="/Users/alexgrabyo/gitrepositories/grabyo/grabyo"
        GITHOMEPATH="/Users/alexgrabyo/gitrepositories"
    fi
else
    ENVIR="linux";
    GRABYOPATH="/home/alex/grabyo"
    GITHOMEPATH="/home/alex"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git lol ruby mvn node sublime)

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
PATH=${PATH}:/Users/alexgrabyo/.local/bin
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
alias tlogr='~/bin/tlog.sh'                                                                                                                                                                                                              
alias add_keys='~/bin/add_keys.sh'
alias mci='mvn -f $GRABYOPATH/pom.xml clean install'
alias mcil='mvn clean tomcat:redeploy'
alias sync='~/bin/sync.sh'
alias tlog='tail -F /var/log/tomcat7/catalina.out'
alias vimlog='vim /var/log/tomcat7/catalina.out'
alias tomst='/usr/share/tomcat7/bin/startup.sh'
alias tomsh='/usr/share/tomcat7/bin/shutdown.sh'
alias pstom='ps aux | grep "tomcat"'
alias mcis='mci -DskipTests=true'
alias mcils='mvn clean tomcat:redeploy -DskipTests=true'
alias gr='cd ~/grabyo'
alias gashl='git --no-pager stash list'
alias syncl='~/bin/synclchc.sh'
alias mcilsl='mvn clean tomcat:redeploy -DskipTests -P localhost && (afplay ~/Music/bathtub_style.mp3)'
alias lsync='nocorrect sudo lsyncd ~/bin/lsync-localhost-config.lua || (afplay ~/Music/bathtub_style.mp3)'
alias sqlw='sh ~/sqlworkbenchj/sqlworkbench.sh &'
alias cdtom='cd /usr/share/tomcat7'
alias rmgrab='rm -r /usr/share/tomcat7/webapps/grabyo*'
alias setenv='vim /usr/share/tomcat7/bin/setenv.sh'
alias hrt='~/bin/hard-reset-tomcat.sh'
alias ebenv='nocorrect ruby $GITHOMEPATH/ruby-scripts/grabyo/aws-eb-env.rb --use-iterm'
alias es='nocorrect ebenv ssh'
alias ess='ebenv ssh studio-prod'
alias lo='libreoffice --calc'
alias vimz='vim ~/.zshrc'
alias srcz='source ~/.zshrc'
alias lpssh='lpass show -c --password 2767727486'
alias syncco='aws s3 sync . s3://conlinoakley.com/ --profile alexconlin --delete'

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
# Terminal colors for vim solarized theme
# export TERM=screen-256color-bce

source /Users/alexgrabyo/.iterm2_shell_integration.zsh

# rbenv
eval "$(rbenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
