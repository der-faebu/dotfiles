# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# This file contains the main settings for zsh.
# env are defined in in ~/.zprofile
# This file is read second after

# source global shell alias & variables files
if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
else
  echo "bash_alias not found"
fi

[ -f "$ZDOTDIR/fzs-bindings.zsh" ] && source "$ZDOTDIR/fzs-bindings.zsh"

# [ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
# autoload -U tetris # main attraction of zsh, obviously


# cmp opts
# zstyle ':completion:*' menu select # tab opens cmp menu
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
source <(fzf --zsh) # allow for fzf history widget

# binds
# vim covered bindings are commented out
# so are bindings used by tmux

# bindkey "^a" beginning-of-line
# bindkey "^e" end-of-line
# bindkey "^k" kill-line
# bindkey "^j" backward-word
# bindkey "^k" forward-word
# bindkey "^H" backward-kill-word
# ctrl J & K for going up and down in prev commands
# used by tmux. somehow redundant if fzf-history is used
# bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget


# open fff file manager with ctrl f
# openfff() {
#  fff <$TTY
#  zle redisplay
#}
#zle -N openfff
#bindkey '^f' openfff


# set up prompt
NEWLINE=$'\n'
# PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

# autosuggestions
# requires zsh-autosuggestions
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package

MY_SHELL=$(echo $SHELL | awk -F '/' '{print $3}')

if [ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/gfa/.lmstudio/bin"
# End of LM Studio CLI section

# Homebrew shennanignans
if [ $(command -v brew) ]; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  set rtp+=$HOMEBREW_PREFIX/opt/fzf
  [ -d "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting" ] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


if command -v tmux>/dev/null; then
tssh() {
  tmux rename-window "$(echo $* | cut -d . -f 1)"
  command ssh "$@"
  tmux set-window-option automatic-rename "on" 1>/dev/null
 }
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi


if [ $(command -v oh-my-posh) ]; then
  # workaround... oh-my-post works with source .bashrc, but not at startup
  eval "$(oh-my-posh init $MY_SHELL --config $HOME/.config/poshthemes/velvet.omp.json)"
fi

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

if [ $(uname) = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
## zinit plugins

# Snippets (adds aliases under the hood)
# Snippets can be https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::command-not-found

#powerlevel 10k
# disabled as it does not behave with tmux and we've got oh-my-posh
# zinit ice depth=1; zinit light romkatv/powerlevel10k


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
    if [ -z "$TMUX" ]; then
        tmux has-session -t TMUX 2>/dev/null \
            && tmux attach -t TMUX \
            || tmux new -s TMUX
    fi
fi

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# start ssh-agent
eval "$(ssh-agent)"
