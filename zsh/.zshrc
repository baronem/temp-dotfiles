#!/bin/bash

################################
### Start Generated Settings ###
################################

setopt extendedglob notify
unsetopt autocd beep nomatch
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mb/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

##############################
### End Generated Settings ###
##############################

# keep history
setopt appendhistory

# colors
autoload -U colors && colors

# environment variables
source $ZDOTDIR/envs

# aliases
source $ZDOTDIR/aliases

# promt
source $ZDOTDIR/prompt

# run pfetch
pfetch
