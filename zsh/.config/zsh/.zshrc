# This file contains the main settings for zsh.
# env are defined in in ~/.zprofile
# This file is read second after ~/.zshenv

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval $(thefuck --alias) 

if [ $(uname) = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[[ -f "$ZDOTDIR/fzs-bindings.zsh" ]] && source "$ZDOTDIR/fzs-bindings.zsh"


# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# cmp opts
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive matching
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
zstyle ':completion:*' menu no

zstyle 'fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle 'fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# main opts
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

setopt appendhistory 
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# setopt append_history inc_append_history share_history # better history
# setopt SHARE_HISTORY unsetopt prompt_sp # don't autoclean blanklines

# fzf setup
# source <(fzf --zsh) # allow for fzf history widget



# open fff file manager with ctrl f
# openfff() {
#  fff <$TTY
#  zle redisplay
#}
#zle -N openfff
# bindkey '^f' openfff


# set up prompt
NEWLINE=$'\n'

MY_SHELL=$(echo $SHELL | awk -F '/' '{print $3}')

if [ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/gfa/.lmstudio/bin"
# End of LM Studio CLI section

# Homebrew shennanignans
if [[ $(command -v brew) ]]; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  set rtp+=$HOMEBREW_PREFIX/opt/fzf
  [[ -d "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


if command -v tmux>/dev/null; then
tssh() {
  tmux rename-window "$(echo $* | cut -d . -f 1)"
  command ssh "$@"
  tmux set-window-option automatic-rename "on" 1>/dev/null
 }
  [[ ! $TERM =~ screen ]] && [[ -z $TMUX ]] && exec tmux
fi

## zinit setup

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

## zinit plugins

# Snippets (adds aliases under the hood)
# Snippets can be https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::command-not-found



# install plugins
# syntax highlighting, autosuggestions, autocompletions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab


# load completions
autoload -U compinit && compinit
# replay cache completions
zinit cdreplay -q
#
# Keybindings
bindkey '^g' autosuggest-accept


if command -v tmux >/dev/null 2>&1; then
    if [[ -z "$TMUX" ]]; then
        tmux has-session -t TMUX 2>/dev/null \
            && tmux attach -t TMUX \
            || tmux new -s TMUX
    fi
fi

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

##### oh-my-zsh config ####
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

if [[ ! -d $ZSH/themes/nord-extended ]]; then
    git clone https://github.com/fxbrit/nord-extended $ZSH/themes/nord-extended
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nord-extended/nord"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### end of oh-my-zsh cofnig ####
#
#


# start ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' >"$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" >/dev/null
    ssh-add; 
}

# Source SSH settings, if applicable

if [[ -f "$SSH_ENV" ]]; then
    . "$SSH_ENV" >/dev/null
    #ps $SSH_AGENT_PID doesn't work under Cygwin
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ >/dev/null || {
        start_agent
    } 
else
    start_agent 
fi
# end ssh agent

# QEMU
if [[ $(command -v kvm) ]]; then
  export LIBVIRT_DEFAULT_URI="qemu:///system"
fi

# opencode
export PATH=/home/gfa/.opencode/bin:$PATH

# activate vim motions
bindkey -v

# Key bindings
# This section should reside at the bottom of zshrc for nothing to get overwritten.

# vim covered bindings are commented out
# so are bindings used by tmux

# bindkey "^a" beginning-of-line
# bindkey "^e" end-of-line
# bindkey "^k" kill-line
# bindkey "^j" backward-word
# bindkey "^k" forward-word
# bindkey "^H" backward-kill-word
# ctrl J & K for going up and down in prev commands
#
# used by tmux. somehow redundant if fzf-history is used
# bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
#
# source global shell alias & variables files
if [[ -f "$HOME/.shell_aliases" ]]; then
  source "$HOME/.shell_aliases"
else
  echo "shell_alias not found"
fi
