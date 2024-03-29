# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/onceiusedwindows/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# loadload a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Theme {{{

export AM_THEME=soft					# chooses color theme
export AM_SHOW_FULL_DIR=0 				# shows the current dir name
export am_PROMPT_END_TAG=' =>'        		# previpusly `PROMPT_END_TAG`
export AM_PROMPT_START_TAG_COLOR=81  	# previpusly `PROMPT_START_TAG_COLOR`
export AM_PROMPT_END_TAG_COLOR=81    	# previpusly `PROMPT_END_TAG_COLOR`
ZSH_THEME="alien-minimal/alien-minimal"

#}}}

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# General settings {{{

#Enables the showing of hidden directories and files when autocompleting.
setopt globdots

#Disable the 'rm' that is triggered by invoking 'rm' with the '*' argument before glob expansion
setopt rm_star_silent

#}}}
# Aliases {{{

alias vls='ls -1aX'
alias hls='ls -aX'

#}}}
# Keybindings {{{

# Go to the beginning of the next word, if there is one. If there are autosuggestions, select until the beginning of the first word in the suggestion.
bindkey "^O" forward-word

# Go to the beginning of the previous word
bindkey "^Z" backward-word

# Unbind "Control + K" to get used to using "Control + J" since the finger movement is less.
bindkey -r "^M"

#}}}
# Functions {{{

# Addѕ a preffix to all the files that meet a pattern.
function preffix()
{
	pattern=$1
	for f in ${~pattern};
		do
			mv $f $2$f;
			echo \"$f\" \-\> \"$2$f\";
		done
}

# Adds a suffix to all the files that meet a pattern.
function suffix()
{
	pattern=$1
	for f in ${~pattern};
		do
			mv $f $f$2;
			echo \"$f\" \-\> \"$f$2\";
		done
}

# Output the type of a block of memory.
function wtype()
{
	if [[ -d $1 ]]
	then
		echo "\"$1\" is a directory"
	elif [[ -f $1 ]]
	then
		echo "\"$1\" is a file"
	else
		echo "\"$1\" is not a valid name"
	fi
}

#}}}
