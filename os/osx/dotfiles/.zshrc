# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git bundler rails zeus zsh-syntax-highlighting)
#plugins=(git bundler ruby colorized nano rails zeus)
plugins=(git bundler ruby colorized nano rails zeus brew history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

##### BOXEN ##### Using Boxen the last time
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

# source /opt/boxen/env.sh

# Some zsh plugins do not work before boxen is loaded
# and some others work when boxen allows their binaries to exist

# we have to require them manually here

# fasd
source $ZSH/plugins/fasd/fasd.plugin.zsh


####### ZEUS 'FIX'
# export ZEUSSOCK=/tmp/zeus.sock

###### ANDROID

# export ANDROID_HOME="$HOME/path/to/android/adt-bundle-mac-x86_64-20140321/sdk"

###### Postgress.app Commandline tools
# http://postgresapp.com/documentation/cli-tools.html
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin

###### Phantomenv ######
# https://github.com/boxen/phantomenv
export PATH="$HOME/.phantomenv/bin:$PATH"
eval "$(phantomenv init -)"

# Rails Spring, disable it
echo "Disabling Spring... DISABLE_SPRING=true"
export DISABLE_SPRING=true

#### hub alias (git=hub) https://github.com/github/hub
eval "$(hub alias -s)"


