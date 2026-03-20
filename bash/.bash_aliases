alias la='ls -A'
alias l='ls -CF'
alias bcat='batcat --paging=never'
alias bat='batcat --paging=never'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
# alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'


# Change directory aliases
alias home='cd $HOME'
alias desk='cd $HOME/Desktop'
alias dl='cd $HOME/Downloads'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias repos="cd $HOME/repos"
alias onedrive="cd $HOME/onedrive"
alias obsidian="cd $HOME/Obsidian"
alias nc="cd $HOME/Nextcloud"

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Flst' # long listing format
alias llr='ls -Flsrt' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# docker alias
alias dpurge='docker image rm $(docker image ls -q) && docker volume rm $(docker volume ls)' 
alias dc='docker compose'

# Kubernetes

alias k='kubectl'
alias h='helm'
kns() {
  if [ -z "$1" ]; then
    echo "Usage: kns <namespace>"
    return 1
  fi

  local NAMESPACE="$1"

  # Update the current namespace in kubectl configuration
  kubectl config set-context --current --namespace="$NAMESPACE"

  if [ $? -eq 0 ]; then
    echo "Switched to namespace: $NAMESPACE"
  else
    echo "Failed to switch namespace to: $NAMESPACE" >&2
    return 1
  fi
}

#functions

## Yazi
alias yazi="flatpak run io.github.sxyazi.yazi"
#
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


## Use nala instead of apt
apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

## Git shizzle
# undo last commit
alias gcu='git reset --soft HEAD~'


## Misc
alias tracert="traceroute -I"
alias mip="ip --br a"
alias mpip="echo $(wget -qO- https://ipecho.net/plain)"

