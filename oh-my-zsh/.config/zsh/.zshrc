# Path to your oh-my-zsh installation.
export ZSH=$HOME/.config/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="fish-like"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux ssh-hosts zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[5~" history-substring-search-up
bindkey "^[[6~" history-substring-search-down

#bindkey -v
#export KEYTIMEOUT=1
TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

alias glog2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n%C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'
alias ll='exa -lg'
alias la='exa -lga'
alias p=pacman
alias ssy='sudo systemctl '
alias cp='cp -av --reflink=auto'


functions ok() {
	true
}

function pacman() {
	if [[ $1 = "--depclean" ]]; then
        sudo pacman -Rns $(command pacman -Qtdq)
    elif [[ $1 = "--browse-installed" ]]; then
        command pacman -Qq | fzf --preview 'command pacman -Qil {}' --layout=reverse --bind 'enter:execute(command pacman -Qil {} | less)'
    elif [[ $1 = "--browse-explicitly-installed" ]]; then
        command pacman -Qqe | fzf --preview 'command pacman -Qil {}' --layout=reverse --bind 'enter:execute(command pacman -Qil {} | less)'
    elif [[ $1 = "-Ss" ]]; then
        pacsearch $@[2,-1]
    else
        sudo pacman "$@"
	fi
}

# Expand aliases
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

# Set window title
DISABLE_AUTO_TITLE="true"

function precmd() {
	print -Pn "\e]0;%n@%M: %~\a"
}

function preexec() {
	print -Pn "\e]0;$1\a"
}

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
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

#export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$(hostname).sock
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export VIMINIT="source $HOME/.config/vim/.vimrc"