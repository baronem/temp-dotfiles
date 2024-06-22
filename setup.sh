#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
ln -sf "$PWD/zsh" "$XDG_CONFIG_HOME"/zsh

ln -sf "$PWD/.zshenv" "$HOME"/.zshenv
