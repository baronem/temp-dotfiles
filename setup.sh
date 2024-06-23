#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config

ln -sf "$PWD/.zshenv" "$HOME"/.zshenv
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/zsh" "$XDG_CONFIG_HOME"/zsh

mkdir $XDG_CONFIG_HOME/bin
mkdir $XDG_CONFIG_HOME/state
mkdir $XDG_CONFIG_HOME/share
mkdir $XDG_CONFIG_HOME/share/zsh

zsh
