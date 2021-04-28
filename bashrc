#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# History 
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# Bash settings
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# If globbing fails, replace with null string, not original pattern
shopt -s failglob

# Autocd
shopt -s autocd

# Set command-line editing to vi mode
set -o vi


# PATH
# If unpriviledged user, append extras to PATH:
if [ "$(whoami)" != root ]; then

    if  [[ ! $PATH =~ $HOME/.local/bin ]]; then
	    PATH=$PATH:$HOME/.local/bin
    fi

    if [[ ! $PATH =~ $HOME/.cargo/bin ]]; then
	    PATH=$PATH:$HOME/.cargo/bin
    fi

    if [[ ! $PATH =~ $HOME/.gem/ruby/3.0.0/bin ]]; then
	    PATH=$PATH:$HOME/.gem/ruby/3.0.0/bin
    fi

    # This will install Ruby Gems to ~/.gems
    export GEM_HOME="$HOME/.gems"
    if [[ ! $PATH =~ "$HOME/.gems/bin" ]]; then
        PATH="$PATH:$HOME/.gems/bin"
    fi

# If root, restrict PATH
else
    PATH=/bin:/usr/bin:/usr/local/bin:/usr/local/sbin
fi

# Figure out what's where
# Set default editor to nvim if it exists
if which nvim > /dev/null 2>&1; then
    export VISUAL=nvim
    export EDITOR=$VISUAL
fi

# fd on Debian-based distro's is fdfind
if which fdfind > /dev/null 2>&1; then
    alias fd=fdfind
fi

# bat on Debian-based distro's is batcat
if which batcat > /dev/null 2>&1; then
    alias bat="batcat --paging='never'"
elif which bat > /dev/null 2>&1; then
    alias bat="bat --paging='never'"
fi

alias ls='ls --color=auto -F'
alias ll='ls --color=auto -alhF'

which ()
    {
        (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
    }
export -f which

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Simple prompt: Prints working directory; colorized
if [ "$(whoami)" = root ]; then
    PS1='\[\033[01;31m\]$PWD\$ \[\033[00m\]'
else
    PS1='\[\033[01m\]$PWD\$ \[\033[00m\]'
fi

function jserve () {
        jekyll serve >/dev/null 2>&1 &
        echo 'http://127.0.0.1:4000'
}

# Environment variables
# For building Linux From Scratch
export LFS=/mnt/lfs

# Colorized GCC warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
